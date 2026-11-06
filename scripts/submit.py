#!/usr/bin/env python3
"""Submit one build job and sequential PBS benchmark jobs."""
import argparse
import csv
import datetime
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess

ROOT=Path(__file__).resolve().parents[1]


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dry-run',action='store_true')
    parser.add_argument('--max-nodes',type=int,choices=[1,2,4,8],default=4)
    parser.add_argument('--repeats',type=int,default=int(os.environ.get('REPEATS','3')))
    parser.add_argument('--tag',default=datetime.datetime.now(datetime.timezone.utc).strftime('%Y%m%dT%H%M%SZ'))
    args=parser.parse_args()
    if args.repeats<1 or not re.fullmatch(r'[A-Za-z0-9_-]+',args.tag):parser.error('Use a positive repeat count and a simple tag')
    cluster=os.environ.get('CLUSTER','cx3')
    if cluster not in ['hx1','cx3']:parser.error('CLUSTER must be hx1 or cx3')
    if cluster=='cx3' and args.max_nodes>4:parser.error('CX3 currently documents a four-node limit; use HX1 for eight nodes')
    cpus=int(os.environ.get('NCPUS_PER_NODE','64'))
    memory=int(os.environ.get('MEM_GB_PER_NODE','256'))
    if cpus<1 or memory<1:parser.error('CPU and memory requests must be positive')
    if not args.dry_run:
        moose=Path(os.environ.get('MOOSE_DIR',''))
        if not (moose/'framework/Makefile').is_file():
            parser.error('Set MOOSE_DIR to a compiled cluster MOOSE installation in cluster.local.env before submitting')
        for executable in ['qsub','make','gfortran','objcopy',os.environ.get('MPIEXEC','mpirun')]:
            if not shutil.which(executable):parser.error(f'{executable} is missing; load the cluster MOOSE/compiler/MPI environment first')
    cases=[]
    with (ROOT/'cases.csv').open() as stream:
        for row in csv.DictReader(stream):
            n,p=int(row['nodes']),int(row['ranks'])
            if n<=args.max_nodes and p%n==0 and p//n<=cpus:cases.append((n,p))
    if not cases:parser.error('No cases fit the requested resources')
    output=ROOT/'results'/args.tag
    if ',' in str(ROOT) or '\n' in str(ROOT):parser.error('PBS environment paths cannot contain commas/newlines')
    if not args.dry_run:
        if output.exists():parser.error('Existing results protected; choose a new --tag')
        (output/'logs').mkdir(parents=True)
    record=dict(cluster=cluster,repeats=args.repeats,allocated_cpus_per_node=cpus,
                memory_gb_per_node=memory,cases=[])
    previous=None
    build_job=None
    for i,case in enumerate([None,*cases]):
        if case is None:
            n,p=1,1
            resources=f'select=1:ncpus={int(os.environ.get("BUILD_JOBS","8"))}:mpiprocs=1:mem=64gb'
            name='hypre-build'
            variables='BENCH_MODE=build'
        else:
            n,p=case
            resources=f'select={n}:ncpus={cpus}:mpiprocs={p//n}:ompthreads=1:mem={memory}gb'
            name=f'hypre-n{n}-p{p}'
            dest=output/f'n{n:02d}_p{p:04d}'
            variables=f'BENCH_MODE=run,BENCH_NODES={n},BENCH_RANKS={p},BENCH_REPEATS={args.repeats},BENCH_OUTPUT={dest}'
        if cluster=='cx3':resources+=':cpu_type='+os.environ.get('CPU_TYPE','icelake')
        cmd=['qsub','-N',name,'-l',resources,'-l','place=scatter:excl',
             '-l','walltime='+('01:00:00' if case is None else os.environ.get('WALLTIME','02:00:00')),
             '-j','oe','-o',str(output/'logs'/f'{name}.log'),'-v',variables]
        if cluster=='hx1':cmd+=['-q','hx']
        if build_job:
            dependency=f'afterok:{build_job}'
            if previous!=build_job:dependency+=f',afterany:{previous}'
            cmd+=['-W','depend='+dependency]
        cmd+=[str(ROOT/'pbs/benchmark.pbs')]
        if args.dry_run:
            print(shlex.join(cmd));job='DRY_BUILD' if case is None else f'DRY_N{n}_P{p}'
        else:
            result=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True,check=True)
            job=result.stdout.strip()
            if not re.fullmatch(r'\d+(?:\.[A-Za-z0-9_.-]+)?',job):raise ValueError('Unexpected qsub job ID: '+job)
        if case is None:build_job=job;record['build_job']=job
        else:record['cases'].append(dict(nodes=n,ranks=p,ranks_per_node=p//n,job_id=job))
        previous=job
        if not args.dry_run:
            temp=output/'submission.json.tmp';temp.write_text(json.dumps(record,indent=2)+'\n');temp.replace(output/'submission.json')
        print(f'{name}: {job}',flush=True)
    print(f'{len(cases)} configurations x {args.repeats} repetitions; results: {output}')


if __name__=='__main__':main()
