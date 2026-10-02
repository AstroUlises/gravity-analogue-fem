#!/usr/bin/env python3
from pathlib import Path
import argparse
p=argparse.ArgumentParser()
p.add_argument('--velocity', type=float, required=True)
p.add_argument('--template', default='case_template.sif')
p.add_argument('--output', default='case.sif')
a=p.parse_args()
text=Path(a.template).read_text()
if '__VELOCITY__' not in text:
    raise SystemExit('template does not contain __VELOCITY__')
Path(a.output).write_text(text.replace('__VELOCITY__', f'{a.velocity:.17g}'))
