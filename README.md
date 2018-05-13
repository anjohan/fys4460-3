# fys4460-3
Files for the percolation project in FYS4460 at the University of Oslo, with implementations in (modern) Fortran.

lib/hk.f90 contains a Fortran implementation of the Hoshen-Kopelman algorithm for cluster labelling.

lib/percolation.f90 contains various useful functions and subroutines for percolation.

## Compilation
Requirements:

* Fortran compiler, preferably gfortran with OpenMP.
* cmake
* lualatex
* latexmk
* Python
* LAPACK

The usual sequence `mkdir build; cd build; cmake ..; make` should build all libraries and executables.

Running `make` from the base directory should build and run all executables and compile the report. Note: This will take a few minutes.
