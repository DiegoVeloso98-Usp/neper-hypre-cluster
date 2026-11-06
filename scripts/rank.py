#!/usr/bin/env python3
"""Record actual rank placement, then replace this process with the solver."""
import json
import os
from pathlib import Path
import socket
import sys
import time

folder=Path(sys.argv[1])
rank=next((int(os.environ[k]) for k in ['OMPI_COMM_WORLD_RANK','PMI_RANK','PMIX_RANK','SLURM_PROCID'] if k in os.environ),None)
if rank is None:raise RuntimeError('Cannot determine MPI rank')
cpus=sorted(os.sched_getaffinity(0))
cores=set()
for cpu in cpus:
    root=Path(f'/sys/devices/system/cpu/cpu{cpu}/topology')
    cores.add((int((root/'physical_package_id').read_text()),int((root/'core_id').read_text())))
model=next((line.split(':',1)[1].strip() for line in Path('/proc/cpuinfo').read_text().splitlines() if line.startswith('model name')),'unknown')
data=dict(rank=rank,host=socket.gethostname(),pid=os.getpid(),cpus=cpus,physical_cores=sorted(cores),
          cpu_model=model,started_at=time.time())
(folder/f'rank_{rank:05d}.json').write_text(json.dumps(data,indent=2)+'\n')
os.execv(sys.argv[2],sys.argv[2:])
