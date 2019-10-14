# Install NWChem with OpenMPI

## Prerequisites
1. Ubuntu (version 14 or higher)
2. NWChem source code
3. OpenMPI
4. root or sudo permission

*Note that the latest stable version of the program of this writing is 6.8.1*

## Step-by-step installation instruction

1. Install all dependencies
```
sudo apt -y install mpi-default-bin libgfortran4 libopenblas-base \
libopenmpi2 libscalapack-openmpi2.0 openmpi-bin libquadmath0 \
libfabric1 libhwloc5 libibverbs1 libpsm-infinipath1 \
openmpi-common libhwloc-plugins libnl-route-3-200 \
ocl-icd-libopencl1  librdmacm1
```

2. Download the tarball of the source of NWChem from its official Github repository https://github.com/nwchemgit/nwchem/releases/latest. For example,
```
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem-6.8.1-release.revision-v6.8-133-ge032219-src.2018-06-14.tar.bz2
```

2. Uncompress the tarball.
```
tar -xvf nwchem-6.8.1-release.revision-v6.8-133-ge032219-src.2018-06-14.tar.bz2
```

3. Go to **src** sub-directory in **nwchem-6.8.1** and create a bash (or tcsh) script called, e.g., **install-nwchem.sh**
```
cd $HOME/nwchem-6.8.1/src
vi install-nwchem.sh
```

4. Add the following commands to the newly created script. However, you can tweak the script as you need.
```sh
#!/bin/bash

export NWCHEM_TOP=/home/ubuntu/nwchem-6.8.1/
export NWCHEM_TARGET=LINUX64
export NWCHEM_MODULES="all python"
export MAKE=/usr/bin/make
export USE_NOFSCHECK=TRUE
export PYTHONHOME=/usr
export PYTHONVERSION=2.7
export USE_PYTHONCONFIG=y
export USE_PYTHON64=y
export HAS_BLAS=yes
export BLASOPT="-lopenblas -lpthread -lrt"
export BLAS_SIZE=4
export USE_64TO32=y
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
## --------------------------------------------------------------------

make nwchem_config
make 64_to_32
make
```

*Note that if you are using OpenMPI 4.0 or higher you must change the MPI library, like this:*
```
sed -i "s/MPI_Errhandler_set/MPI_Comm_set_errhandler/g" $NWCHEM_TOP/src/tools/ga-5.6.5/tcgmsg/tcgmsg-mpi/misc.c
sed -i "s/MPI_Type_struct/MPI_Type_create_struct/g" $NWCHEM_TOP/src/tools/ga-5.6.5/comex/src-armci/message.c
```
For more information please visit https://www-lb.open-mpi.org/faq/?category=mpi-removed.

5. Execute the script to start installation. This can take 20-30 minutes, depending on the performance of compiler and system.
```
./install-nwchem.sh
```

6. If it is done without any error, a NWChem executable binary file can be found at $NWCHEM_TOP/bin/LINUX64/. For example,
```
/home/ubuntu/nwchem-6.8.1/bin/LINUX64/nwchem
```

7. Create a resouce file and put it as a hidden file under your home directory.
