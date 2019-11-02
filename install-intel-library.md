# Install Intel Library

Intel Parallel Studio XE suite
- Intel C++ compiler
- Intel Fortran compiler
- Intel MKL
- Intel MPI
- Intel Distribution for Python (optional)

## Prerequisites

- Development tools
- root or sudo permission (for global)

## Installing development tools

- Red Hat/CentOS

```
sudo yum update && sudo yum install wget lsb gcc-c++ expect
```

- Ubuntu

```
sudo apt-get upgrade && sudo apt-get install wget lsb gcc expect
```

## Preparing package installer

- Download installer of Intel Parallel Studio XE suite or library from Intel software center
- Untar the archive

```
tar –xvf <package_name>.tgz
```

Execute bash installer (.sh) and follow the onscreen instruction to complete installation 

```
sh ./<package_name>.sh
```

Installation can take 5 - 20 min depending on the packages to be installed

## Intel C++ and Fortran Compilers

1. Download software installer from the Intel software center
2. Execute the following commands

```
tar -xvzf l_comp_lib_2018.2.199_comp.cpp_redist.tgz
cd  l_comp_lib_2018.2.199_comp.cpp_redist
sudo ./install.sh
```

## Intel MKL

1. Download software installer from the Intel software center
2. Execute the following commands

```
tar -xvzf l_mkl_2018.2.199.tgz
cd l_mkl_2018.2.199
sudo ./install.sh
cp -r /shared/opt/intel/mkl/benchmarks/hpcg /home/centos/hpcg
```

## Intel MPI

1. Download software installer from https://registrationcenter.intel.com/RegCenter/ComForm.aspx?ProductID=1744.
2. Uncompress the tarball and execute shell file to start installation

```
tar -xvzf l_mpi-rt_2018.2.199.tgz
cd l_mpi-rt_2018.2.199
sudo ./install.sh
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
