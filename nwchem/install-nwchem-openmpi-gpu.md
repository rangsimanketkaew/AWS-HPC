# Install NWChem with OpenMPI

## Prerequisites
1. Ubuntu (version 14 or higher)
2. NWChem source code
3. OpenMPI (version 1.6.x - 3.x.x)
4. NVIDIA graphic card*
5. NVIDIA driver*
6. CUDA toolkit*
7. root or sudo permission (needed for installation at global directory)

*Note that the latest stable version of NWChem of this writing is 6.8.1*

\* = To enable the compilation of CUDA code for coupled-cluster method

## Step-by-step installation instruction

1. Install all dependencies
```
sudo apt -y install mpi-default-bin libgfortran4 libopenblas-base \
libopenmpi2 libscalapack-openmpi2.0 openmpi-bin libquadmath0 \
libfabric1 libhwloc5 libibverbs1 libpsm-infinipath1 \
openmpi-common libhwloc-plugins libnl-route-3-200 \
ocl-icd-libopencl1  librdmacm1
```

> Note that the above command will install OpenMPI version 2.1.1 (on the day of writing).

2. Download the tarball of the source of NWChem from official Github repository https://github.com/nwchemgit/nwchem/releases/latest, for example, to your home directory
```
cd $HOME
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem-6.8.1-release.revision-v6.8-133-ge032219-src.2018-06-14.tar.bz2
```

3. Uncompress the tarball
```
tar -xvf nwchem-6.8.1-release.revision-v6.8-133-ge032219-src.2018-06-14.tar.bz2
```

4. Create a bash (or tcsh) script called, e.g., **install-nwchem-openmpi-gpu.sh**
```
vi install-nwchem-openmpi-gnu.sh
```

5. Add the following commands to the newly created script. However, you can tweak the script as you need.
```sh
#!/bin/bash

# Install NWChem with parallel method and GPU on AWS EC2 system.
# Ubuntu OS
# Compile with GNU compiler and OpenMPI v.4.0.
# GNU BLAS
# NVIDIA CUDA
 
export NWCHEM_TOP=/home/ubuntu/nwchem-6.8.1/

## ---------------------- NWChem comfiguration ------------------------
export NWCHEM_TARGET=LINUX64
export NWCHEM_MODULES="all python"
export MAKE=/usr/bin/make
export USE_NOFSCHECK=TRUE
## ---------------------- Python --------------------------------------
export PYTHONHOME=/usr
export PYTHONVERSION=2.7
export USE_PYTHONCONFIG=y
export USE_PYTHON64=y
## ---------------------- CC & FC compilers ---------------------------
export CC="gcc"
export FC="gfortran"
## ---------------------- Special method compilation ------------------
export MRCC_METHODS=TRUE
export CCSDTQ=y
export CCSDTLR=y
export IPCCSD=y
export EACCSD=y
## ---------------------- MPI Libraries box ---------------------------
export USE_MPI=y
export USE_MPIF=y
export USE_MPIF4=y
export MPI_LOC=/usr/local/
#export MPI_LIB=/usr/local/lib
#export MPI_INCLUDE=/usr/local/include
#export LIBMPI="-lmpi_usempi -lmpi_mpifh -lmpi"
#export LIBMPI="-lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
## ---------------------- Math library --------------------------------
export HAS_BLAS=yes
export BLASOPT="-lopenblas -lpthread -lrt"
export BLAS_SIZE=4
#------------------------ Convert 64 to 32 bit ------------------------
export USE_64TO32=y
#--------------------------- GPU Enabled ------------------------------
export TCE_CUDA=Y
export CUDA="nvcc"
export CUDA_LIBS="-L/usr/local/cuda-10.1/lib64/ -L/usr/local/cuda-10.1/lib64/ -lcudart"
export CUDA_FLAGS="-arch sm_50 "
export CUDA_INCLUDE="-I. -I/usr/local/cuda-10.1/include/"
## --------------------------------------------------------------------

cd $NWCHEM_TOP/src

make nwchem_config
make 64_to_32
make
```

**Very important note for OpenMPI version 4.0 or higher**

As OpenMPI 4.0 changed the name of the functions, we have to tweak the name in the following files before compiling the program. e.g.

```
export NWCHEM_TOP=/home/ubuntu/nwchem-6.8.1/
sed -i "s/MPI_Errhandler_set/MPI_Comm_set_errhandler/g" $NWCHEM_TOP/src/tools/ga-5.6.5/tcgmsg/tcgmsg-mpi/misc.c
sed -i "s/MPI_Type_struct/MPI_Type_create_struct/g" $NWCHEM_TOP/src/tools/ga-5.6.5/comex/src-armci/message.c
...
Configuration parameter snipped off
...
make nwchem_config
make 64_to_32
make
```

For more information please visit https://www-lb.open-mpi.org/faq/?category=mpi-removed.

6. Execute the script to start installation. This can take 20-30 minutes, depending on the performance of compiler and system.
```
./install-nwchem-openmpi-gpu.sh
```

7. If it is done without any error, a NWChem executable binary file can be found at $NWCHEM_TOP/bin/LINUX64/. For example,
```
/home/ubuntu/nwchem-6.8.1/bin/LINUX64/nwchem
```

8. Create a resource file and put it as a hidden file under your home directory.
