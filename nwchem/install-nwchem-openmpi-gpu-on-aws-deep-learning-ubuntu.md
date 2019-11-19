# Install NWChem with OpenMPI & GPU enabled on pre-configured AWS Deep Learning Ubuntu AMI

## Prerequisites
1. AWS Ubuntu ([Deep Learning AMI (Ubuntu 18.04) Version 25.3 - ami-0d21095cdfb1566c2](https://aws.amazon.com/marketplace/pp/B07Y43P7X5?qid=1574192208398&sr=0-1&ref_=srh_res_product_title))
2. NWChem source code (6.8.1 or higher)
3. GNU compiler (gcc and gfortran)
4. OpenBLAS
5. OpenMPI (version 3.1.4)
6. Python (version 2.6 or 2.7)
7. NVIDIA driver*
8. CUDA toolkit*
9. root or sudo permission (needed for installation at global directory)

\* = required to enable the compilation of CUDA code for coupled-cluster method

## Step-by-step installation instruction

1. Install all dependencies

```
sudo apt update && sudo apt -y upgrade
sudo apt -y install libopenblas-base libscalapack-openmpi2.0 tcsh
```

2. Download the tarball of the source of NWChem from official Github repository https://github.com/nwchemgit/nwchem/releases/latest, for example, to your home directory

```
cd $HOME
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem-6.8.1-release.revision-v6.8-133-ge032219-src.2018-06-14.tar.bz2
```

3. Uncompress the tarball

```
tar -xvf nwchem-6.8.1-release.revision-v6.8-133-ge032219-src.2018-06-14.tar.bz2
```

4. Create a bash (or tcsh) script called, e.g., *install-nwchem-openmpi-gpu.sh*

```
vi install-nwchem-openmpi-gpu.sh
```

5. Add the following commands to the newly created script. However, you can tweak the script as you need.

```sh
#!/bin/bash

# Install NWChem with parallel method and GPU on AWS EC2 system.
# AWS Deep Learning Ubuntu Base AMI 18.04
# Compile with GNU compiler and OpenMPI version 3.1.4
# GNU OpenBLAS
# NVIDIA driver and CUDA toolkit 10.1
 
module purge
module load openmpi/3.1.4-2

export NWCHEM_TOP=/home/ubuntu/nwchem-6.8.1/

## ---------------------- NWChem comfiguration ------------------------
export NWCHEM_TARGET=LINUX64
export NWCHEM_MODULES="all"
export USE_NOFSCHECK=TRUE
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
# output of guess-mpidefs script.
export MPI_INCLUDE="/opt/amazon/openmpi/include -I/opt/amazon/openmpi/lib"
export MPI_LIB="/opt/amazon/openmpi/lib"
export LIBMPI="-lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
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
make 64_to_32 >& make_64to32.log
make FC=gfortran >& make.log
```

6. Execute the script to start installation.

```
chmod +x install-nwchem-openmpi-gpu.sh
./install-nwchem-openmpi-gpu.sh
```

This can take 30 - 50 minutes depending on the performance of the configuration, compiler and the system.

7. If it is done without any error, the executable binary file can be found at `$NWCHEM_TOP/bin/LINUX64/nwchem`. For example,

```
/home/ubuntu/nwchem-6.8.1/bin/LINUX64/nwchem
```

8. Create a hidden NWChem resource file called `.nwchemrc` and put it at your home directory.

```
vi $HOME/.nwchemrc
```

Add the following commands to `.nwchemrc` file:

```
nwchem_basis_library <location of NWChem installation>/src/basis/libraries/
nwchem_nwpw_library <location of NWChem installation>/src/nwpw/libraryps/
ffield amber
amber_1 <location of NWChem installation>/src/data/amber_s/
amber_2 <location of NWChem installation>/src/data/amber_q/
amber_3 <location of NWChem installation>/src/data/amber_x/
amber_4 <location of NWChem installation>/src/data/amber_u/
spce   <location of NWChem installation>/src/data/solvents/spce.rst
charmm_s <location of NWChem installation>/src/data/charmm_s/
charmm_x <location of NWChem installation>/src/data/charmm_x/
```

where `<location of NWChem installation>` is `$NWCHEM_TOP`.

9. All test files are available at `$NWCHEM_TOP/QA/tests`.
