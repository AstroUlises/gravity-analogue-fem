# Primary-source notes used to assemble FEM-01/A

- Partovi, M. H. & Morris, E. J., "Electrodynamics of a Magnet Moving through a Conducting Pipe", arXiv:physics/0406085. Analytic axisymmetric finite-cylinder / finite-thickness-shell drag benchmark.
- ElmerCSC/elmerfem current source, `fem/src/modules/MagnetoDynamics2D.F90`: 2D Cartesian and cylindrically symmetric magnetic vector-potential solver; reads `Lorentz velocity` and adds the motional `v x curl A` term.
- ElmerCSC/elmerfem `fem/src/SOLVER.KEYWORDS`: declares `Lorentz Velocity 1`, `2`, `3` as BodyForce real inputs.
- ElmerCSC/elmerfem `fem/src/modules/MagnetoDynamics/CalcFields.F90`: supports `Calculate Joule Heating` and exports the field.
- Elmer release 8.1 notes / current SaveScalars source: material/body/body-force masked scalar operators are supported.

The Elmer code references were checked against commit 6cc96530bbfd7fa1cb8803f4cae878461cd2c1e1 surfaced by the connected GitHub source during assembly.
