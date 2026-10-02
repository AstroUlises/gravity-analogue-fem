#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
for c in gmsh ElmerGrid ElmerSolver python3; do
  command -v "$c" >/dev/null || { echo "ERROR: missing $c" >&2; exit 2; }
done

MESH_SCALE="${MESH_SCALE:-1.0}"
echo "[1/3] Meshing with MeshScale=$MESH_SCALE"
rm -rf mesh geometry.msh field*.vtu case.sif power.dat fem_raw.csv
gmsh -2 geometry.geo -setnumber MeshScale "$MESH_SCALE" -format msh2 -o geometry.msh
ElmerGrid 14 2 geometry.msh -out mesh -autoclean

echo "v_m_s,joule_power_W,F_drag_N" > fem_raw.csv

echo "[2/3] Running blind velocity sweep"
tail -n +2 velocities.csv | while IFS=, read -r v; do
  [ -z "$v" ] && continue
  tag=$(printf '%.3f' "$v" | tr '.' 'p')
  echo "  v=$v m/s"
  python3 render_case.py --velocity "$v"
  rm -f power.dat
  ElmerSolver case.sif > "elmer_v${tag}.log" 2>&1
  P=$(python3 extract_power.py power.dat)
  F=$(python3 - <<PY
v=float('$v'); P=float('$P'); print(f'{P/abs(v):.17g}')
PY
)
  echo "$v,$P,$F" >> fem_raw.csv
done

echo "[3/3] Blind run complete: fem_raw.csv"
echo "Do NOT tune geometry after looking at the reference. Compare only after this file is frozen."
sha256sum fem_raw.csv | tee fem_raw.csv.sha256
