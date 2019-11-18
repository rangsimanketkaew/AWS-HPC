# Install NWChem with OpenMPI

## Prerequisites
1. Ubuntu (version 14.04 or higher)
2. NWChem source code (6.8.1 or higher)
3. OpenMPI (version 1.6.x - 3.x.x)
4. Python (version 2.6 or 2.7)
5. NVIDIA driver*
6. CUDA toolkit*
7. root or sudo permission (needed for installation at global directory)

\* = required to enable the compilation of CUDA code for coupled-cluster method

## Step-by-step installation instruction

1. Install all dependencies
```
sudo apt -y install gfortran libgfortran4 mpi-default-bin libopenblas-base \
libopenmpi2 libscalapack-openmpi2.0 openmpi-bin libquadmath0 \
libfabric1 libhwloc5 libibverbs1 libpsm-infinipath1 \
openmpi-common libhwloc-plugins libnl-route-3-200 \
ocl-icd-libopencl1  librdmacm1 \
python-dev tcsh make
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

4. As `MPI_LIB`, `MPI_INCLUDE`, and `LIBMPI` parameters are not fixed (it depends on the environment of the system). Execute `$HOME/nwchem-6.8.1/src/tools/guess-mpidefs` shell script to get the suitable MPI libraries.

```
./home/ubuntu/nwchem-6.8.1/src/tools/guess-mpidefs
export MPI_INCLUDE="/usr/lib/x86_64-linux-gnu/openmpi/include -I/usr/lib/x86_64-linux-gnu/openmpi/lib"
export MPI_LIB="/usr//lib -L/usr/lib/x86_64-linux-gnu/openmpi/lib"
export LIBMPI="-I/usr/lib/x86_64-linux-gnu/openmpi/include -I/usr/lib/x86_64-linux-gnu/openmpi/lib -L/usr/lib/x86_64-linux-gnu/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
```

In case `guess-mpidefs` cannot find the MPI libraries, maybe `mpif90` command is not yet installed on your system. So you can use the following command to install mpif90

```
sudo apt -y install libopenmpi-dev
```

5. Create a bash (or tcsh) script called, e.g., *install-nwchem-openmpi-gpu.sh*
```
vi install-nwchem-openmpi-gnu.sh
```

6. Add the following commands to the newly created script. However, you can tweak the script as you need.
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
# output of guess-mpidefs script.
export MPI_INCLUDE="/usr/lib/x86_64-linux-gnu/openmpi/include -I/usr/lib/x86_64-linux-gnu/openmpi/lib"
export MPI_LIB="/usr//lib -L/usr/lib/x86_64-linux-gnu/openmpi/lib"
export LIBMPI="-I/usr/lib/x86_64-linux-gnu/openmpi/include -I/usr/lib/x86_64-linux-gnu/openmpi/lib -L/usr/lib/x86_64-linux-gnu/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi"
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

**Very important note for OpenMPI version 4.0 or higher**

As OpenMPI 4.0 changed the name of the functions, we have to tweak the name in the following files before compiling the program. e.g.

```
#!/bin/bash

export NWCHEM_TOP=/home/ubuntu/nwchem-6.8.1/

sed -i "s/MPI_Errhandler_set/MPI_Comm_set_errhandler/g" $NWCHEM_TOP/src/tools/ga-5.6.5/tcgmsg/tcgmsg-mpi/misc.c
sed -i "s/MPI_Type_struct/MPI_Type_create_struct/g" $NWCHEM_TOP/src/tools/ga-5.6.5/comex/src-armci/message.c

...
Configuration parameters snipped off
...

make nwchem_config
make 64_to_32
make
```

For more information please visit https://www-lb.open-mpi.org/faq/?category=mpi-removed.

7. Execute the script to start installation. This can take 20-30 minutes, depending on the performance of compiler and system.
```
./install-nwchem-openmpi-gpu.sh
```

8. If it is done without any error, the executable binary file can be found at `$NWCHEM_TOP/bin/LINUX64/nwchem`. For example,

```
/home/ubuntu/nwchem-6.8.1/bin/LINUX64/nwchem
```

9. Create a hidden NWChem resource file called `.nwchemrc` and put it at your home directory.

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

10. All test files are available at `$NWCHEM_TOP/QA/tests`.
