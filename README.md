# FEM-01/A — blind Elmer benchmark

This package is the first independent FEM gate for the analogue-gravity eddy-current project. It intentionally contains no expected Partovi-Morris force table.

## Required software
- Gmsh
- ElmerGrid + ElmerSolver, with MagnetoDynamics2D / MagnetoDynamicsCalcFields
- Python 3

## Run
```bash
./run_sweep.sh
```
This creates `fem_raw.csv` and `fem_raw.csv.sha256`.

For the mesh convergence triplet:
```bash
./run_mesh_convergence.sh
```

Only after the blind result is frozen, unpack the separate `reference_key` and run:
```bash
python3 compare_after_reveal.py --reference ../reference_key/reference_PM.csv
```

## Model frame
The magnet is fixed and the conducting shell moves axially using Elmer's `Lorentz Velocity` body-force field. This is the stationary relative-motion formulation. The sign of velocity reverses induced-current direction but not Joule power; the benchmark compares the drag magnitude.

## Force observable
The primary observable is not a numerically differentiated energy or a fitted damping coefficient. Elmer computes `Joule Heating`; `SaveScalars` integrates it only over material carrying `CopperMask=True`, then the run script forms `F=P/|v|`.

## Why this setup is grounded in Elmer source
Current Elmer source declares `Lorentz Velocity 1/2/3` as BodyForce inputs. MagnetoDynamics2D reads this vector and adds the `v x curl A` contribution; its source also supports axisymmetric/cylindrically symmetric 2D cases. MagnetoDynamicsCalcFields exports `Joule Heating` when requested. SaveScalars supports material-masked integral operators.

## Status
The package was assembled and statically audited here, but Elmer/Gmsh were not available in this runtime, so **no FEM result is claimed yet**. FEM-01/A becomes executed only when `fem_raw.csv` is produced by Elmer.
