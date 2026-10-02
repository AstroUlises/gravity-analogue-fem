#!/usr/bin/env python3
import csv, argparse
from pathlib import Path
p=argparse.ArgumentParser()
p.add_argument('--fem', default='fem_raw.csv')
p.add_argument('--reference', required=True)
p.add_argument('--threshold-percent', type=float, default=1.0)
p.add_argument('--output', default='comparison.csv')
a=p.parse_args()
with open(a.fem,newline='') as f: fem={round(float(r['v_m_s']),12):r for r in csv.DictReader(f)}
with open(a.reference,newline='') as f: ref={round(float(r['v_m_s']),12):r for r in csv.DictReader(f)}
rows=[]
for v in sorted(fem):
    if v not in ref: raise SystemExit(f'missing reference at v={v}')
    Ff=float(fem[v]['F_drag_N']); Fr=float(ref[v]['F_PM_N'])
    err=100*(Ff-Fr)/Fr
    rows.append((v,Ff,Fr,err,abs(err)))
with open(a.output,'w',newline='') as f:
    w=csv.writer(f); w.writerow(['v_m_s','F_FEM_N','F_PM_N','signed_error_percent','abs_error_percent']); w.writerows(rows)
mx=max(r[4] for r in rows)
print(f'max_abs_relative_error_percent={mx:.6g}')
print('PASS' if mx < a.threshold_percent else 'FAIL')
raise SystemExit(0 if mx < a.threshold_percent else 1)
