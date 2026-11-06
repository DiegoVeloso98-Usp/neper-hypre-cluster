#!/usr/bin/env python3
"""Prepare the exact mesh, launch fixed-work MPI cases, and validate saved evidence."""
import argparse
from collections import Counter
import csv
import datetime
import gzip
import hashlib
import json
import math
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import time

ROOT=Path(__file__).resolve().parents[1]
EVENTS=['SNESJacobianEval','SNESFunctionEval','KSPSolve','PCSetUp','PCApply','MatMult','MatAssemblyBegin','MatAssemblyEnd','VecScatterBegin','VecScatterEnd']


def atomic(path,data):
    temp=path.with_suffix(path.suffix+'.tmp')
    temp.write_text(json.dumps(data,indent=2)+'\n');temp.replace(path)


def sha(path):
    h=hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda:stream.read(1024*1024),b''):h.update(block)
    return h.hexdigest()


def prepare():
    metadata=json.loads((ROOT/'mesh/metadata.json').read_text())
    mesh=ROOT/'mesh/polycrystal_1000.inp'
    if mesh.exists():
        if sha(mesh)!=metadata['sha256']:raise ValueError('Existing mesh checksum differs')
        return
    temp=mesh.with_suffix('.inp.tmp')
    with gzip.open(mesh.with_suffix('.inp.gz'),'rb') as source,temp.open('wb') as dest:
        shutil.copyfileobj(source,dest)
    if sha(temp)!=metadata['sha256']:
        temp.unlink();raise ValueError('Decompressed mesh checksum differs')
    temp.replace(mesh)


def provenance():
    build=ROOT/'.build';build.mkdir(exist_ok=True)
    data=dict(python=sys.version,platform=os.uname().sysname+' '+os.uname().release,
              moose_dir=os.environ.get('MOOSE_DIR'),method='opt',threads_per_rank=1,
              captured_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),
              files={str(p.relative_to(ROOT)):sha(p) for p in [ROOT/'benchmark.i',ROOT/'mesh/metadata.json',*sorted((ROOT/'umat').glob('*.f*'))]})
    for key,cmd in [('mpi',['mpirun','--version']),('compiler',['gfortran','--version']),
                    ('moose_commit',['git','-C',os.environ.get('MOOSE_DIR',''),'rev-parse','HEAD'])]:
        try:data[key]=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=15).stdout
        except (OSError,subprocess.TimeoutExpired) as error:data[key]=str(error)
    for key in ['PETSC_DIR','PETSC_ARCH','LIBMESH_DIR']:data[key]=os.environ.get(key)
    executable=ROOT/'app/umat_oxford-opt'
    if executable.exists():data['executable_sha256']=sha(executable)
    atomic(build/'provenance.json',data)


def launcher(ranks,per_node,kind):
    if kind=='slurm':
        if not os.environ.get('SLURM_JOB_ID'):raise ValueError('Slurm allocation required')
        return ['srun','--mpi=pmi2','--ntasks',str(ranks),'--cpus-per-task=1',
                '--ntasks-per-core=1','--cpu-bind=threads','--distribution=block:cyclic:cyclic','--kill-on-bad-exit=1']
    if not os.environ.get('PBS_JOBID'):raise ValueError('PBS allocation required')
    binary=shutil.which(os.environ.get('MPIEXEC','mpirun'))
    if not binary:raise ValueError('MPI launcher not found; configure cluster.local.env')
    kind=os.environ.get('MPI_KIND','auto') if kind=='auto' else kind
    version=subprocess.run([binary,'--version'],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,check=True).stdout.lower()
    if kind=='auto':
        if 'open mpi' in version or 'openrte' in version:kind='openmpi'
        elif 'intel' in version:kind='intel'
        elif 'hydra' in version or 'mpich' in version:kind='mpich'
        else:raise ValueError('Unknown MPI implementation; set MPI_KIND')
    if kind=='openmpi':
        sockets=int(os.environ.get('MPI_SOCKETS_PER_NODE','2'))
        major=re.search(r'(?:open mpi|openrte)[^\d]*(\d+)\.',version)
        object_name='package' if major and int(major[1])>=5 else 'socket'
        mapping=f'ppr:{per_node//sockets}:{object_name}:PE=1' if sockets>0 and per_node%sockets==0 else f'ppr:{per_node}:node:PE=1'
        return [binary,'-np',str(ranks),'--hostfile',os.environ['PBS_NODEFILE'],
                '--map-by',mapping,'--bind-to','core','--report-bindings']
    if kind=='intel':
        os.environ.update(I_MPI_PIN='1',I_MPI_PIN_DOMAIN='core',I_MPI_PIN_ORDER='scatter')
        return [binary,'-v6','-np',str(ranks),'-ppn',str(per_node)]
    if kind=='mpich':
        return [binary,'-n',str(ranks),'-ppn',str(per_node),'-f',os.environ['PBS_NODEFILE'],'-bind-to','core','-map-by','socket']
    raise ValueError('MPI_KIND must be openmpi, intel or mpich')


def profile(path):
    result={}
    for line in path.read_text().splitlines():
        fields=line.split()
        if fields and fields[0] in EVENTS:
            result[fields[0]]=dict(count=int(fields[1]),seconds=float(fields[3]),max_min_time_ratio=float(fields[4]))
    for name in ['SNESJacobianEval','SNESFunctionEval','KSPSolve','PCSetUp','PCApply']:
        if name not in result:raise ValueError('Missing PETSc event '+name)
    return result


def validate(dest,ranks,nodes):
    with (dest/'history.csv').open() as stream:rows=list(csv.DictReader(stream))
    if len(rows)!=6 or int(float(rows[-1]['iteration']))!=5 or abs(float(rows[-1]['time'])-5e-6)>1e-12:
        raise ValueError('Expected initial state and all five load steps')
    if any(not math.isfinite(float(v)) for row in rows for v in row.values()):
        raise ValueError('Nonfinite history value')
    if max(abs(float(row['max_gcum'])) for row in rows)>1e-12:raise ValueError('Inelastic response')
    if any(int(float(row['nonlinear_iterations']))<1 or int(float(row['linear_iterations']))<1 for row in rows[1:]):
        raise ValueError('A forced solve was skipped')
    with (ROOT/'reference/history.csv').open() as stream:reference=list(csv.DictReader(stream))
    errors={}
    for group,keys,floor in [('stress',['avg_sigma_11','avg_sigma_22','avg_sigma_33'],1e-8),
                             ('strain',['avg_strain_11','avg_strain_22','avg_strain_33'],1e-12)]:
        error=0.0
        for row,ref in zip(rows[1:],reference[1:]):
            if abs(float(row['time'])-float(ref['time']))>1e-12:raise ValueError('Reference time differs')
            norm=math.sqrt(sum(float(ref[k])**2 for k in keys))
            error=max(error,math.sqrt(sum((float(row[k])-float(ref[k]))**2 for k in keys))/max(norm,floor))
        errors[group+'_relative_error']=error
    if max(errors.values())>1e-4:raise ValueError('Reference accuracy failed: '+str(errors))
    events=profile(dest/'petsc_profile.txt')
    jac=sum(int(float(row['nonlinear_iterations'])) for row in rows[1:])
    if events['SNESJacobianEval']['count']!=jac:raise ValueError('Current Jacobian not reassembled')
    if not (1<=events['PCSetUp']['count']<jac and events['PCApply']['count']>=jac):raise ValueError('AMG reuse not verified')
    records=[json.loads(p.read_text()) for p in sorted((dest/'affinity').glob('rank_*.json'))]
    if len(records)!=ranks or {r['rank'] for r in records}!=set(range(ranks)):raise ValueError('Missing MPI rank records')
    if any(len(r['physical_cores'])!=1 for r in records):raise ValueError('Each rank must bind to one physical core')
    hosts=Counter(r['host'] for r in records)
    if len(hosts)!=nodes or set(hosts.values())!={ranks//nodes}:raise ValueError('MPI node distribution differs from request')
    if len({r['cpu_model'] for r in records})!=1:raise ValueError('Mixed CPU models in one benchmark')
    cores=[(r['host'],*r['physical_cores'][0]) for r in records]
    if len(set(cores))!=ranks:raise ValueError('Physical cores shared between ranks')
    affinity=dict(passed=True,hosts=dict(hosts),distinct_physical_cores=ranks,records=records)
    atomic(dest/'affinity_summary.json',affinity)
    atomic(dest/'events.json',events)
    with (dest/'events.csv').open('w',newline='') as stream:
        writer=csv.DictWriter(stream,fieldnames=['event','count','seconds','max_min_time_ratio']);writer.writeheader()
        writer.writerows(dict(event=name,**values) for name,values in events.items())
    timings=[]
    for old,row in zip(rows,rows[1:]):
        timings.append(dict(step=int(float(row['iteration'])),time=float(row['time']),
            solve_seconds=float(row['solve_seconds'])-float(old['solve_seconds']),
            linear_iterations=int(float(row['linear_iterations'])),nonlinear_iterations=int(float(row['nonlinear_iterations']))))
    with (dest/'timing.csv').open('w',newline='') as stream:
        writer=csv.DictWriter(stream,fieldnames=list(timings[0]));writer.writeheader();writer.writerows(timings)
    return dict(elastic_verified=True,preconditioner_reused=True,current_jacobian_reassembled=True,
                pc_setups=events['PCSetUp']['count'],jacobian_seconds=events['SNESJacobianEval']['seconds'],
                residual_seconds=events['SNESFunctionEval']['seconds'],ksp_seconds=events['KSPSolve']['seconds'],
                amg_setup_seconds=events['PCSetUp']['seconds'],**errors)


def run(args):
    if args.nodes<1 or args.ranks<1 or args.ranks%args.nodes or args.repeats<1:raise ValueError('Invalid node/rank/repeat counts')
    if not (os.environ.get('PBS_JOBID') or os.environ.get('SLURM_JOB_ID')):raise ValueError('Scheduler allocation required')
    prepare()
    executable=Path(os.environ.get('BENCH_EXECUTABLE',str(ROOT/'app/umat_oxford-opt'))).resolve()
    if not executable.is_file() or not (ROOT/'umat/UMAT-opt.plugin').is_file():raise ValueError('Run ./build first')
    prefix=launcher(args.ranks,args.ranks//args.nodes,args.launcher)
    output=args.output.resolve()
    if output.exists():raise ValueError('Existing result directory protected: '+str(output))
    output.mkdir(parents=True)
    if os.environ.get('PBS_NODEFILE'):shutil.copyfile(os.environ['PBS_NODEFILE'],output/'pbs_nodefile.txt')
    if (ROOT/'.build/provenance.json').exists():shutil.copyfile(ROOT/'.build/provenance.json',output/'build_provenance.json')
    env=dict(os.environ,CP_MPI_SIZE=str(args.ranks),OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
    template=(ROOT/'benchmark.i').read_text()
    for repeat in range(1,args.repeats+1):
        dest=output/f'repeat_{repeat:02d}';dest.mkdir();(dest/'affinity').mkdir()
        inp=dest/'benchmark.i'
        inp.write_text(template.replace('@MESH@',str(ROOT/'mesh/polycrystal_1000.inp'))
                      .replace('@UMAT@',str(ROOT/'umat/UMAT')).replace('@OUTPUT@',str(dest/'history')))
        command=[*prefix,sys.executable,str(ROOT/'scripts/rank.py'),str(dest/'affinity'),str(executable),
                 '-i',str(inp),'--n-threads=1','-ksp_converged_reason','-ksp_view',
                 '-pc_hypre_boomeramg_print_statistics','1','-log_view',':'+str(dest/'petsc_profile.txt')]
        metadata=dict(status='running',grains=1000,elements=1000000,nodes=args.nodes,processes=args.ranks,
            ranks_per_node=args.ranks//args.nodes,threads_per_rank=1,repeat=repeat,dt=1e-6,steps=5,
            variant='hypre_reuse',job_id=os.environ.get('PBS_JOBID',os.environ.get('SLURM_JOB_ID')),
            command=command,started_utc=datetime.datetime.now(datetime.timezone.utc).isoformat())
        metadata['transport_environment']={k:env[k] for k in ['UCX_TLS','UCX_NET_DEVICES','FI_PROVIDER','I_MPI_FABRICS','OMPI_MCA_pml'] if k in env}
        atomic(dest/'run.json',metadata)
        started=time.perf_counter()
        try:
            with (dest/'run.log').open('w') as log:
                result=subprocess.run(command,cwd=dest,env=env,stdout=log,stderr=subprocess.STDOUT)
            metadata.update(wall_seconds=time.perf_counter()-started,returncode=result.returncode)
            if result.returncode:raise ValueError('Solver failed; see run.log')
            metadata.update(validate(dest,args.ranks,args.nodes),status='success')
            atomic(dest/'run.json',metadata)
            print(f'Repeat {repeat}: validated, {metadata["wall_seconds"]:.3f} seconds',flush=True)
        except BaseException as error:
            metadata.update(status='failed',error=str(error),wall_seconds=time.perf_counter()-started)
            atomic(dest/'run.json',metadata);raise


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    sub=parser.add_subparsers(dest='mode',required=True)
    sub.add_parser('prepare');sub.add_parser('provenance')
    p=sub.add_parser('run');p.add_argument('--nodes',type=int,required=True);p.add_argument('--ranks',type=int,required=True)
    p.add_argument('--repeats',type=int,default=1);p.add_argument('--output',type=Path,required=True)
    p.add_argument('--launcher',choices=['auto','openmpi','intel','mpich','slurm'],default='auto')
    args=parser.parse_args()
    if args.mode=='prepare':prepare()
    elif args.mode=='provenance':provenance()
    else:run(args)


if __name__=='__main__':main()
