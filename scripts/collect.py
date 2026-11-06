#!/usr/bin/env python3
"""Collect validated repetitions into CSV; plot if matplotlib is installed."""
import argparse
import csv
import json
from pathlib import Path
import statistics

ROOT=Path(__file__).resolve().parents[1]


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory',nargs='?',type=Path,default=ROOT/'results')
    args=p.parse_args();base=args.directory.resolve()
    results=[];groups={}
    for path in sorted(base.rglob('repeat_*/run.json')):
        r=json.loads(path.read_text())
        if r['status']!='success':continue
        row={k:r[k] for k in ['nodes','processes','ranks_per_node','repeat','wall_seconds',
                             'jacobian_seconds','residual_seconds','ksp_seconds','amg_setup_seconds',
                             'pc_setups','stress_relative_error','strain_relative_error','job_id']}
        row['source']=str(path.parent.relative_to(base));results.append(row)
        groups.setdefault((r['nodes'],r['processes']),[]).append(row)
    if not results:raise SystemExit('No validated results yet')
    with (base/'runs.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(results[0]));w.writeheader();w.writerows(results)
    summary=[]
    for (n,ranks),rows in sorted(groups.items()):
        values=[r['wall_seconds'] for r in rows]
        summary.append(dict(nodes=n,processes=ranks,ranks_per_node=ranks//n,repetitions=len(rows),
            median_wall_seconds=statistics.median(values),min_wall_seconds=min(values),max_wall_seconds=max(values),
            median_jacobian_seconds=statistics.median(r['jacobian_seconds'] for r in rows),
            median_residual_seconds=statistics.median(r['residual_seconds'] for r in rows),
            median_ksp_seconds=statistics.median(r['ksp_seconds'] for r in rows),
            median_amg_setup_seconds=statistics.median(r['amg_setup_seconds'] for r in rows)))
    with (base/'summary.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(summary[0]));w.writeheader();w.writerows(summary)
    print(f'Collected {len(results)} validated runs in {len(summary)} configurations: {base}/summary.csv')
    try:
        import matplotlib
        matplotlib.use('Agg')
        import matplotlib.pyplot as plt
    except ImportError:
        print('CSV saved. Install matplotlib only if you also want plots.');return
    fig,axes=plt.subplots(1,2,figsize=(12,4.5))
    for nodes in sorted({r['nodes'] for r in summary}):
        data=sorted([r for r in summary if r['nodes']==nodes],key=lambda r:r['processes'])
        axes[0].plot([r['processes'] for r in data],[r['median_wall_seconds'] for r in data],'o-',label=f'{nodes} node(s)')
    for ranks in sorted({r['processes'] for r in summary}):
        data=sorted([r for r in summary if r['processes']==ranks],key=lambda r:r['nodes'])
        if len(data)>1:axes[1].plot([r['nodes'] for r in data],[r['median_wall_seconds'] for r in data],'o-',label=f'{ranks} total ranks')
    axes[0].set(xlabel='Total MPI ranks',ylabel='Median wall time (s)',title='Fixed 1,000-crystal problem',yscale='log')
    axes[1].set(xlabel='Nodes',ylabel='Median wall time (s)',title='Same rank count, spread over more nodes',yscale='log')
    for ax in axes:
        ax.grid(alpha=.25)
        if ax.lines:ax.legend(fontsize=8)
    fig.tight_layout()
    for ext in ['png','pdf']:fig.savefig(base/f'comparison.{ext}',dpi=180)
    plt.close(fig)


if __name__=='__main__':main()
