#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
rm -f mesh_convergence_summary.csv
rm -rf convergence_logs
mkdir -p convergence_logs
echo "mesh_scale,raw_csv,sha256" > mesh_convergence_summary.csv
for s in 1.4 1.0 0.7; do
  echo "=== MeshScale=$s ==="
  MESH_SCALE="$s" ./run_sweep.sh
  tag=$(echo "$s" | tr '.' 'p')
  cp fem_raw.csv "fem_raw_mesh_${tag}.csv"
  mkdir -p "convergence_logs/mesh_${tag}"
  cp elmer_v*.log "convergence_logs/mesh_${tag}/" 2>/dev/null || true
  h=$(sha256sum "fem_raw_mesh_${tag}.csv" | awk '{print $1}')
  echo "$s,fem_raw_mesh_${tag}.csv,$h" >> mesh_convergence_summary.csv
done
