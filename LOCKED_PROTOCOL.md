# FEM-01/A locked protocol

## Purpose
Independent axisymmetric Elmer test of the uniform conducting-pipe eddy-current drag benchmark before any Schwarzschild or Painleve-Gullstrand geometry is shown to the solver.

## Frozen physical parameters
- magnetic moment: 0.67 A m^2
- magnet radius: 6.3 mm
- magnet length: 6.4 mm
- tube inner radius: 7.29 mm
- tube outer radius: 7.96 mm
- conductivity: 5.08e7 S/m
- relative permeability: 1
- magnet: uniformly axially magnetized cylinder
- velocities: 0.02, 0.05, 0.10, 0.20, 0.30, 0.52 m/s

## Numerical formulation
Axisymmetric (r,z) MagnetoDynamics2D. Magnet fixed; the copper tube is assigned a uniform axial Lorentz velocity. Drag magnitude is extracted independently from the stationary power balance

    F_drag = P_Joule / |v|

where P_Joule is the volume integral of Joule heating in copper only.

## Blindness rule
The Elmer SIF, geometry, meshing scripts and run_sweep.sh contain no Partovi-Morris expected force values. `fem_raw.csv` must be generated and SHA-256 frozen before the reference key is used.

## Acceptance rule (preregistered)
PASS iff max over the six velocities of

    abs(F_FEM - F_PM) / F_PM < 0.01.

No Schwarzschild/PG variable-wall simulation is unlocked if this test fails.

## Mesh check
Run at MeshScale = 1.4, 1.0, 0.7. A credible PASS additionally requires the force curve to show numerical convergence; the medium-to-fine change should be comfortably below the 1% physics acceptance threshold. A 0.5% medium-to-fine target is recommended.

## No post-hoc tuning
Far-field dimensions, material properties, magnetization and velocity set are frozen in v1. If a numerical pathology requires a change, create v2 and document why; do not silently overwrite v1.
