# Install Mathematics Library for Scientific Calculation

This tutorial covers the installation instructions of following items:

- ATLAS
- BLACS
- LAPACK
- ScaLAPACK

## Credit

Adapted from original version by Marcin Skoczylas: http://aragorn.pb.bialystok.pl/~mars/tutorial/scalapack/

## Prerequisites

- OpenMPI installed and configured with Fortran (mpif77 -v)
- GCC with g77 (sudo yum groupinstall "Development Tools")

## ATLAS

1. Download ATLAS from math-atlas.sourceforge.net

Configure compiling setup

```
cd /root
tar -xzvf atlas3.8.0.tar.gz
mkdir /root/ATLAS_BUILD
cd /root/ATLAS_BUILD
/root/ATLAS/configure
```

Then compile ATLAS:

```
make
make check
make ptcheck
make time
make install
```

ATLAS will be installed by default at /usr/local/atlas. You should also add ATLAS library to `LD_LIBRARY_PATH`.

## BLACS

1. Download BLACS from www.netlib.org/blacs

```
cd /root
tar -xzvf mpiblacs.tgz
tar -xzvf mpiblacs-patch03.tgz
cd BLACS
cp ./BMAKES/BMake.MPI-LINUX Bmake.inc
```

Edit Bmake.inc and perform these changes (taken from OpenMPI FAQ):

\# Section 1: \
\# Ensure to use MPI for the communication layer

```
   COMMLIB = MPI
```

\# The MPIINCdir macro is used to link in mpif.h and\
\# must contain the location of Open MPI's mpif.h.\
\# The MPILIBdir and MPILIB macros are irrelevant \
\# and should be left empty.

```
   MPIdir = /path/to/openmpi-1.2.4
   MPILIBdir =
   MPIINCdir = $(MPIdir)/include
   MPILIB =
```

\# Section 2:
\# Set these values:

```
   SYSINC =
   INTFACE = -Df77IsF2C
   SENDIS =
   BUFF =
   TRANSCOMM = -DUseMpi2
   WHATMPI =
   SYSERRORS =
```

\# Section 3:\
\# You may need to specify the full path to\
\# mpif77 / mpicc if they aren't already in\
\# your path.

```
   F77            = mpif77
   F77LOADFLAGS   = 

   CC             = mpicc
   CCLOADFLAGS    = 
```

Then compile BLACS with MPI:

```
make mpi
```

Edit the BLACS/TESTING/Makefile and change that line:

```
blacstest.o : blacstest.f
	$(F77) $(F77NO_OPTFLAGS) -c $*.f
```

to:

```
	$(F77) $(F77NO_OPTFLAGS) -fno-globals -fno-f90 -fugly-complex -w -c $*.f
```

and then compile BLACS tests:

```
cd /root/BLACS/TESTING
make
run tests:
cd /root/BLACS/TESTING/EXE
mpirun -np 5 xCbtest_MPI-LINUX-0
mpirun -np 5 xFbtest_MPI-LINUX-0
```

if tests passed, you can install the BLACS library to /usr/local/lib for example by:

```
chmod 555 /root/BLACS/LIB/*.a 
cp /root/BLACS/LIB/*.a /usr/local/lib
```

## LAPACK

1. Download LAPACK from www.netlib.org/lapack

```
cd /root
tar -xzvf lapack.tgz
```

Rename the directory where it was extracted, lapack-3.1.1 to LAPACK

```
cd /root/LAPACK
cp make.inc.example make.inc
```

Edit make.inc and perform these changes:

```
#BLASLIB = ../../blas$(PLAT).a
BLASLIB = /usr/local/atlas/lib/libf77blas.a /usr/local/atlas/lib/libatlas.a
```

Then compile LAPACK:

```
make
When it's done, install the LAPACK library:
chmod 555 /root/LAPACK/*.a
cp /root/LAPACK/*.a /usr/local/lib
```

## ScaLAPACK

1. Download ScaLAPACK from www.netlib.org/scalapack
   
```
cd /root
tar -xzvf scalapack.tgz
```

Rename the directory where it was extracted, scalapack-1.8.0 to SCALAPACK and enter:

```
cd SCALAPACK
cp SLmake.inc.example SLmake.inc
```

Edit SLmake.inc and make these changes:

\# Make sure you follow the instructions to build BLACS with Open MPI,\
\# and put its location in the following.\

```
   BLACSdir      = /usr/local/lib
```

\# The MPI section is commented out.  Uncomment it. The wrapper\
\# compiler will handle SMPLIB, so make it blank. The rest are correct\
\# as is.

```
   USEMPI        = -DUsingMpiBlacs
   SMPLIB        = 
   BLACSFINIT    = $(BLACSdir)/blacsF77init_MPI-$(PLAT)-$(BLACSDBGLVL).a
   BLACSCINIT    = $(BLACSdir)/blacsCinit_MPI-$(PLAT)-$(BLACSDBGLVL).a
   BLACSLIB      = $(BLACSdir)/blacs_MPI-$(PLAT)-$(BLACSDBGLVL).a
   TESTINGdir    = $(home)/TESTING
```

\# The PVMBLACS setup needs to be commented out.\

```
   #USEMPI        =
   #SMPLIB        = $(PVM_ROOT)/lib/$(PLAT)/libpvm3.a -lnsl -lsocket
   #BLACSFINIT    =
   #BLACSCINIT    =
   #BLACSLIB      = $(BLACSdir)/blacs_PVM-$(PLAT)-$(BLACSDBGLVL).a
   #TESTINGdir    = $(HOME)/pvm3/bin/$(PLAT)
```

\# You may need to specify the full path to mpif77 / mpicc if they\
\# aren't already in your path.

```
   F77            = mpif77
   F77LOADFLAGS   = 

   CC             = mpicc
   CCLOADFLAGS    = 
```

\# Make sure that the BLASLIB points to the right place. 

```
   BLASLIB = /usr/local/atlas/lib/libf77blas.a /usr/local/atlas/lib/libatlas.a
   LAPACKLIB = /usr/local/lib/lapack_LINUX.a
```

Ok, so now compile ScaLAPACK by:

```
cd /root/SCALAPACK
make
make exe
```

and optionally:

```
make example
```

Then you can try to run tests:

```
cd /root/SCALAPACK/TESTING
mpirun -np 5 ./xdlu ./LU.dat
mpirun -np 5 ./xdllt ./LLT.dat
```

Install the ScaLAPACK library by:

```
chmod 555 /root/SCALAPACK/libscalapack.a
cp /root/SCALAPACK/libscalapack.a /usr/local/lib
```
