#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
source_dir="$PWD"
build_dir=$(mktemp -d "${TMPDIR:-/tmp}/oxford-plugin.XXXXXX")
trap 'rm -rf -- "$build_dir"' EXIT
read -r -a flags <<< "${FFLAGS:--O2}"

# Build in a clean directory: gfortran searches the current directory for
# .mod files first, so old modules with different parameter dimensions must
# never be mixed into a new plugin.
cp -- "$source_dir"/*.f "$source_dir/moose_uexternaldb.f90" "$build_dir/"
cd "$build_dir"

# UMAT.f includes the vendor modules. Build them unchanged, then interpose
# the MOOSE-specific initialization adapter without editing the vendor entry.
gfortran "${flags[@]}" -fPIC -ffixed-form -J"$build_dir" \
  -c UMAT.f -o "$build_dir/UMAT.o"
objcopy --redefine-sym uexternaldb_=oxford_uexternaldb_ "$build_dir/UMAT.o"
gfortran "${flags[@]}" -fPIC -I"$build_dir" -J"$build_dir" \
  -c moose_uexternaldb.f90 -o "$build_dir/moose_uexternaldb.o"
gfortran -shared -o "$build_dir/UMAT-opt.plugin" \
  "$build_dir/UMAT.o" "$build_dir/moose_uexternaldb.o"
mv -- "$build_dir/UMAT-opt.plugin" "$source_dir/UMAT-opt.plugin"

echo "Built $source_dir/UMAT-opt.plugin"
