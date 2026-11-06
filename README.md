# 1,000-crystal Hypre / AMG-reuse benchmark

This is the same fixed problem used on the workstation: 1,000 crystals,
1,000,000 HEX8 elements, 1,030,301 nodes, 3,090,903 displacement DoFs, the
same grain orientations and Oxford UMAT, five forced elastic load steps of
`1e-6`, Newton + GMRES + Hypre BoomerAMG, strength threshold `0.7`, linear
tolerances `1e-6` / `1e-12`, complete AMG reuse with refresh threshold 25.
One thread per rank; no GPU; no other meshes or solver variants.

## Run on Imperial CX3

Prerequisite: a **compiled MOOSE installation with solid_mechanics and
PETSc/Hypre, built against the MPI you will run on the cluster**. The tested
workstation MOOSE revision is `98907de29962187fe16760caa66f882a810b8242`
(PETSc 3.25.4). Prefer the same revision. This repository contains the small
application and UMAT sources, not MOOSE or workstation executables.

On the cluster, in a shared project/work directory visible from every node:

```bash
git clone <repository-url>
cd neper-hypre-cluster
cp cluster.env cluster.local.env
nano cluster.local.env
./run
```

In `cluster.local.env`, load your existing MOOSE compiler/MPI environment and
set `MOOSE_DIR` to that compiled installation. `CLUSTER=cx3` is already the
default. An activation shell file can be specified with `MOOSE_ENV`.
Use the same environment for compilation and execution. Do not mix Conda
MPI with a different cluster MPI. There is no assumed MOOSE module name.

**After that one-time environment setup, `./run` is the submission command.**
It submits one build job (unpack/check mesh, build app, build UMAT), then
eleven sequential benchmark jobs, with three complete repetitions in each:

| Nodes | Total MPI ranks |
|---:|---|
| 1 | 8, 16, 32, 64 |
| 2 | 32, 64, 128 |
| 4 | 32, 64, 128, 256 |

Every compute job reserves all 64 physical cores and 256 GB per node, even
when using fewer ranks. `mpiprocs` specifies active ranks per node; the
remaining allocated cores stay idle. `scatter:excl` requests distinct,
exclusive nodes. CX3 requests `cpu_type=icelake` to avoid mixing Intel and
AMD machines. HX1's documented CPU nodes are 64-core Intel Ice Lake.
HX1 uses the `hx` routing queue; CX3 lets PBS choose the queue.

```bash
./run --dry-run                     # print every qsub command, submit nothing
./run --repeats 1                   # quick first pass
qstat -u "$USER"                    # monitor jobs
./collect                          # make runs.csv, summary.csv; plots if matplotlib exists
```

`cases.csv` is the editable job matrix. `--max-nodes` defaults to 4. CX3's
current guidance limits jobs to four nodes. Eight-node cases are optional
for HX1 only (`CLUSTER=hx1 ./run --max-nodes 8`), not part of this CX3 sweep.
The default two-hour time limit covers each configuration's three runs;
adjust `WALLTIME` if your cluster needs longer. Builds have a one-hour limit.
Every invocation creates a new timestamped results directory and submission
manifest. Existing cases are never overwritten. Cases wait for the build
to succeed and then run sequentially; a failed case does not erase evidence
or prevent later configurations from being attempted.

MPI flavour is detected, or set `MPI_KIND=openmpi`, `intel` or `mpich`.
Intel MPI uses Imperial's documented `mpirun -v6` launch option. The OpenMPI
launch sets ranks per node and binds one physical core per rank. The code
spreads OpenMPI ranks evenly over both sockets of each Ice Lake node, so
under-filled nodes can still use both sockets' memory channels.
`MPI_SOCKETS_PER_NODE=2` describes this hardware; adjust it if the CPU target
changes. Intel MPI uses scatter pinning.
The code
checks actual host distribution and physical-core affinity after every run;
incorrect or shared-core placement invalidates the measurement.
No workstation TCP-only transport restrictions are copied to the cluster.

## Results to send back

Send the complete timestamped `results/<timestamp>/` directory. Each repeat
keeps `run.log`, `run.json`, `history.csv`, `timing.csv`, the complete
`petsc_profile.txt`, parsed `events.csv`/`events.json`, and per-rank affinity
evidence. The job also records its PBS nodefile and build provenance.
Mesh integrity, all five steps, elastic response, averaged-field agreement
with the workstation reference, actual AMG reuse, and current Jacobian
assembly are checked before a result is accepted.

```bash
./collect results/<timestamp>
tar -czf cluster-results.tar.gz results/<timestamp>
```

Timings are launcher wall time (including mesh loading/startup) and per-step
solve time, matching the workstation definitions. PETSc event totals span
all five steps and are maxima across ranks; inclusive events can overlap.
`summary.csv` uses medians across repeats, while `runs.csv` retains every
observation. Generated results are ignored by Git but retained on disk and
in the returned archive.

## What this experiment can establish

Start with **32 or 64 total ranks held fixed across 1, 2 and 4 nodes**. The
mesh and rank count then stay fixed while memory/cache resources increase
and network communication is introduced. Separately compare increasing
rank counts for strong scaling. More nodes are not automatically better:
the local work shrinks and communication/coarse-grid overhead can dominate.

Improvement when distributing a fixed rank count supports a shared-resource
bottleneck; it does **not prove DRAM-bandwidth saturation**. Cache capacity,
NUMA placement, CPU frequency and communication also change. Record memory
bandwidth/hardware counters in a follow-up to distinguish those effects.
The cluster and workstation have different CPUs, so use the cluster's own
one-node runs as the controlled baseline for its multi-node comparison.
Compare the assembly and solver event times as well as whole-run time:
multi-node mesh loading and shared-filesystem I/O can otherwise obscure the
compute-phase scaling you are trying to diagnose.

## Contents and provenance

- `benchmark.i`: complete input, with the same 1,000 grain material definitions.
- `mesh/polycrystal_1000.inp.gz`: the exact cleaned workstation mesh, compressed
  below GitHub's per-file limit; decompression verifies `mesh/metadata.json`.
- `app/`: only the minimal MOOSE app sources needed to register solid_mechanics.
- `umat/`: the already validated rank-local Oxford UMAT sources and build script.
  GND/nonlocal backstress are disabled. `CP_MPI_SIZE` explicitly sets rank-local
  storage capacity across MPI implementations; constitutive equations are unchanged.
- `reference/`: the small strict-tolerance workstation history and provenance.
- `pbs/`, `scripts/`, `run`, `build`, `collect`: submission, building and validation.

The Oxford UMAT headers retain their original authorship (Eralp Demir,
Ed Tarleton, Nicolo Grilli and Fionn Dunne); application sources were adapted
from the existing `moose-cp` project. The inherited LGPL-2.1 license is in
`LICENSE`. No compiled libraries, MOOSE tree, Neper installation, other meshes,
slides or old simulation output are included.

If MOOSE is not already installed, build the tested revision with the site's
GCC/native-MPI toolchain, including Hypre, following the official MOOSE HPC
instructions below. A source build is a separate prerequisite, not something
the benchmark silently installs on a login node.

## Documentation

Validation on 6 November 2026: the included app and UMAT compiled against the
tested MOOSE installation, and the full 1,000-crystal case passed on 30 MPI
ranks under workstation Slurm (623.845 s; one AMG setup, five current
Jacobians, elastic and strict-reference checks passed). A clean source
checkout passed mesh verification and the CX3 dry run. PBS submission and
MPI command construction were checked locally; execution on CX3 itself
requires the recipient's cluster MOOSE/MPI environment and account.

To publish this already initialized local Git repository, first create an
empty GitHub repository named `neper-hypre-cluster` (without a generated
README/license), then run:

```bash
git remote add origin https://github.com/YOUR-USERNAME/neper-hypre-cluster.git
git push -u origin main
```

Keep cluster-specific activation paths in ignored `cluster.local.env`.
Share the repository URL with your friend; it needs no Git LFS setup.

- [Imperial HX1: PBS sizes, under-filled nodes and MPI launching](https://icl-rcs-user-guide.readthedocs.io/en/latest/hpc/hx1/)
- [Imperial CX3: job sizing and automatic queue routing](https://icl-rcs-user-guide.readthedocs.io/en/latest/hpc/queues/job-sizing-guidance/)
- [MOOSE installation methods](https://mooseframework.inl.gov/getting_started/installation/index.html)
- [PETSc performance and memory bandwidth](https://petsc.org/release/manual/performance/)
