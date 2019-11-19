# Install Intel Compiler

Packages: 

- Intel C++ compiler
- Intel Fortran compiler

## FAQ

> Q: Where can I find all Intel products? </br>
> A: https://registrationcenter.intel.com/en/products/
>
> Q: Are they free? </br>
> A: Yes, Intel is so generous. Student, teacher, open-source developer can download Intel Parallel Studio XE in free of charge!

## Prerequisites

- Basic development tools (`sudo yum group install "Development Tools"`)
- root or sudo permission (for installation at global space)

## Installing development tools

- Red Hat/CentOS

```
sudo yum update && sudo yum install wget lsb gcc-c++ expect
```

- Ubuntu

```
sudo apt-get update
sudo apt-get upgrade && sudo apt-get install wget lsb gcc expect
```

## Intel C++ and Fortran Compilers

1. Download software installer from the Intel software center
2. Execute the following commands

```
tar -xvzf l_comp_lib_2018.2.199_comp.cpp_redist.tgz
cd  l_comp_lib_2018.2.199_comp.cpp_redist
sudo ./install.sh
```

FYI: Compilers info

| Language | Developer | Command | MPI  | OpenMP |
|----------|-----------|---------|------|--------|
| Fortran 77 | GNU | gfortran | mpif77 | gfortran -fopenmp |
| Fortran 90/95/03 | GNU | gfortran | mpif90 | gfortran -fopenmp |
| C | GNU | gcc (cc) | mpicc | gcc -fopenmp |
| C++ | GNU | g++ (c++) | mpicxx (mpic++, mpiCC) | g++ -fopenmp |
| Fortran 77 | PGI | pgfortran (pgf77) | mpif77 | pgfortran -mp |
| Fortran 90/95/03 | PGI | pgfortran (pgf90, pgf95) | mpif90 | pgfortran -mp |
| C | PGI | pgcc | mpicc | pgcc -mp |
| C++ | PGI | pgc++ | mpicxx (mpic++, mpiCC) | pgc++ -mp |
| Fortran 77/90/95/03 | Intel | ifort | mpifort (mpif90, mpif77) | ifort -openmp |
| C | Intel | icc | mpicc | icc -openmp |
| C++ | Intel | icpc | mpicxx (mpic++, mpiCC) | icpc -openmp |

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
