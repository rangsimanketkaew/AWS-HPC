# Install Intel Library

## Intel MPI

1. Download software installer from https://registrationcenter.intel.com/RegCenter/ComForm.aspx?ProductID=1744.
2. Uncompress the tarball and execute shell file to start installation

```
tar -xvzf l_mpi-rt_2018.2.199.tgz
cd l_mpi-rt_2018.2.199
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

## Intel C++ and Fortran Compilers

1. Download software installer from the Intel software center
2. Execute the following commands

```
tar -xvzf l_comp_lib_2018.2.199_comp.cpp_redist.tgz
cd  l_comp_lib_2018.2.199_comp.cpp_redist
sudo ./install.sh
```

## Contact 

Rangsiman Ketkaew - rangsiman1993@gmail.com

