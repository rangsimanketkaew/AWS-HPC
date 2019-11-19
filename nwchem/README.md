# Installing NWChem 

## Getting Started

NWChem is a quantum chemistry and molecular dynamics software which provides comprehensive many methods such as Hartree-Fock (HF), post-Hartree-Fock (post-HF), Density Functional Theory (DFT), classical molecular dynamics (MD), and hybrid quantum mechanics/molecular mechanics (QM/MM) for computing the properties of molecule. NWChem is an open-source, fast, efficient, and powerful. The program algorithm is optimized and designed to run with distributed-memory parallel method on Linux cluster across multiple compute nodes.

Website: http://www.nwchem-sw.org
Github: https://github.com/nwchemgit/nwchem
Documentation: https://github.com/nwchemgit/nwchem/wiki

## Specification of AWS EC2 instance I used for writing this page

On the day of this writing:

- I have compiled and installed NWChem on CentOS 7 and Ubuntu 18.04 with and without GPU CUDA accelerator.
- Instance type
  - CPU instance: t2.micro (free tier)
  - CPU instance: c5.4xlarge - 16 CPU cores
  - GPU instance: g3s.xlarge - 4 CPU cores + 1 GPU
- Storage
  - SSD
  - 30 GiB (free tier)

## Install NWChem on AWS EC2 cluster

### Prerequisites

- root or sudo permission (for installing program at global level)
- C++ and Fortran compilers such as GNU or Intel compiler
- MPI library such as Intel MPI and OpenMPI
- Math library such as Intel MKL, BLAS, LAPACK, and ScaLAPACK
- Make
- ARMCI platform (optional)

Please note that on the day of this writing the latest version of NWChem is 6.8.1.

### Creating Bash script for automated installation

Example of Bash script for compiling and installing NWChem 6.8.1 on different Linux distributions:

1. CentOS 7
2. CentOS 7 with GPU
3. CentOS 7 with GPU and ARMCI=MPI-PR
4. CentOS 8 with GPU and ARMCI=MPI-PR
5. Ubuntu 18.04
6. Ubuntu 18.04 with GPU

### Let's compile and install NWChem

1. Create and execute the install (bash) script with MPI on your system
   - [OpenMPI on Ubuntu](install-nwchem-openmpi.md)
   - [OpenMPI + GPU on Ubuntu](install-nwchem-openmpi-gpu.md)
   - [OpenMPI + GPU on AWS Deep Learning Ubuntu AMI](install-nwchem-openmpi-gpu-on-aws-deep-learning-ubuntu.md)
   - OpenMPI on Red Hat/CentOS
   - Intel MPI on Red Hat/CentOS
   - Intel MPI + GPU on Red Hat/CentOS
   - MPICH MPI on Red Hat/CentOS
   - MPICH MPI + GPU on Red Hat/CentOS
   - MVAPICH2 MPI on Red Hat/CentOS
   - MVAPICH2 MPI + GPU on Red Hat/CentOS
2. Wait for 20 - 40 min - depending on configuration setting, compiler and system performance
3. NWChem executable binary will be created at `$NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem`

where `$NWCHEM_TOP` and `$NWCHEM_TARGET` are environment variables that define the top directory of `nwchem-6.8.1` and platform of machine such as `LINUX64`.

### Running NWChem

- Normal running command

```
mpirun -np N -ppn M /full/path/to/nwchem input.nw >& output.out &
```

- Running command with Casper

```
export NWCHEM_CASLIB=/full/path/to/casper/lib

mpirun -np N -ppn M -genv CSP_NG 1 -genv LD_PRELOAD $NWCHEM_CASLIB/libcasper.so \
        /full/path/to/nwchem input.nw >& output.out
```

where N is the total number of MPI processes and M is the total number of MPI processes per node.

*Note that casper can be used with only ARMCI method in order to speed up the calculation.*

## Submitting NWChem job to the cluster by SGE and SLURM

- SGE

[SGE scripts for submitting NWChem jobs](../sge)

- SLURM

[SLURM scripts for submitting NWChem jobs](../slurm)

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
