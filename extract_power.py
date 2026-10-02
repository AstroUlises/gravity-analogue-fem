#!/usr/bin/env python3
"""Extract the final numeric scalar from Elmer SaveScalars output."""
from pathlib import Path
import argparse,re
p=argparse.ArgumentParser(); p.add_argument('file', nargs='?', default='power.dat'); a=p.parse_args()
path=Path(a.file)
if not path.exists(): raise SystemExit(f'missing {path}')
rows=[]
for line in path.read_text(errors='replace').splitlines():
    s=line.strip()
    if not s or s.startswith('#'): continue
    vals=[]
    for tok in re.split(r'[\s,;]+',s):
        try: vals.append(float(tok.replace('D','E').replace('d','e')))
        except ValueError: pass
    if vals: rows.append(vals)
if not rows: raise SystemExit(f'no numeric data found in {path}')
print(f'{rows[-1][-1]:.17g}')
