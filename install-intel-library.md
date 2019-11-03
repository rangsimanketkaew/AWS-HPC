# Install Intel Development Tools and Library

Some important and frequently-used libraries:

- Intel C++ compiler
- Intel Fortran compiler
- Intel Math Kernel Library (MKL)
- Intel Message Passing Interface (MPI)
- Intel Distribution for Python (optional)

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

## Preparing package installer

1. Download installer of Intel Parallel Studio XE suite or library from Intel software center

```
wget <package_name>.tgz
```

2. Untar the archive

```
tar –xvf <package_name>.tgz
```

3. Execute bash installer (.sh) and follow the onscreen instruction to complete installation 

```
sh ./<package_name>.sh
```

_Installation can take 5 - 20 min, depending on the packages to be installed._

---

# Individual installation

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

> FYI: [Intel Math Kernel Library Link Line Advisor](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor)

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
