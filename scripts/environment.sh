#!/usr/bin/env bash
BENCH_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
set -a
source "$BENCH_ROOT/cluster.env"
if [[ -f "$BENCH_ROOT/cluster.local.env" ]]; then source "$BENCH_ROOT/cluster.local.env"; fi
if [[ -n "$MOOSE_ENV" ]]; then source "$MOOSE_ENV"; fi
set +a
# Keep one application thread per rank. Leave MPI transport selection to the
# cluster MPI: never copy the workstation's UCX_TLS=sm,self,tcp restriction.
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1
export METHOD=opt METHODS=opt
