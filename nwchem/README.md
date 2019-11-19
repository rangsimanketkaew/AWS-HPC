# Installing NWChem 

## Getting Started

NWChem is a quantum chemistry and molecular dynamics software which provides comprehensive many methods such as Hartree-Fock (HF), post-Hartree-Fock (post-HF), Density Functional Theory (DFT), classical molecular dynamics (MD), and hybrid quantum mechanics/molecular mechanics (QM/MM) for computing the properties of molecule. NWChem is an open-source, fast, efficient, and powerful. The program algorithm is optimized and designed to run with distributed-memory parallel method on Linux cluster across multiple compute nodes.

Website: http://www.nwchem-sw.org
Github: https://github.com/nwchemgit/nwchem
Documentation: https://github.com/nwchemgit/nwchem/wiki

## Specification of AWS EC2 instance I used for writing this page

- I compiled and installed NWChem 6.8.1 and 7.0.0 beta 1 on Red Hat 8, CentOS 7, Ubuntu 16.04, and Ubuntu 18.04 with and without enabling GPU (CUDA).
- Instance types
  - CPU instance: t2.micro (free tier)
  - CPU instance: c5.xlarge - 4 CPU cores
  - CPU instance: c5.4xlarge - 16 CPU cores
  - GPU instance: g3s.xlarge - 4 CPU cores + 1 GPU
- Storage
  - SSD
  - 30 GiB (free tier)

## 1. General prerequisites for compiling program

- C++ and Fortran compilers such as Intel or GNU compiler
- MPI library such as Intel MPI or OpenMPI
- Math library such as Intel MKL (BLAS, LAPACK, and ScaLAPACK) or GNU OpenBLAS and OpenScaLAPACK
- Make
- Python 2.6 or 2.7
- ARMCI (optional)
- Casper (optional)
- root or sudo permission (needed for installing program at global space)

## 2. Creating Script containing all configuration parameters

[NWChem documentation - Compiling NWChem](https://github.com/nwchemgit/nwchem/wiki/Compiling-NWChem)

> Look at the bottom of this page for example of Bash scripts

## 3. Starting compilation

Execute the script to start compilation using the following commands

```
chmod +x INSTALL_NWCHEM_SCRIPT.sh
./INSTALL_NWCHEM_SCRIPT.sh
```

## 4. During compilation

1. Compilation and installation can take 20 - 60 min depending on configuration setting, compiler and system performance.
2. If it is done successfully, the NWChem executable binary will be created at `$NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem` by default.

where `$NWCHEM_TOP` and `$NWCHEM_TARGET` are environment variables that define the top directory of `nwchem-6.8.1` and platform of machine such as `LINUX64`.

### 5. Running NWChem

- Normal running command

```
mpirun -np N /$NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem input.nw >& output.out &
```

- Normal running command with specifying the number of processes per node

```
mpirun -np N -ppn M /$NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem input.nw >& output.out &
```

- Running command with Casper

```
export NWCHEM_CASLIB=/full/path/to/casper/lib

mpirun -np N -ppn M -genv CSP_NG 1 \
        -genv LD_PRELOAD $NWCHEM_CASLIB/libcasper.so \
        /$NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem input.nw >& output.out
```

where N is the total number of MPI processes and M is the total number of MPI processes per node.

*Note that casper can be used with only ARMCI method in order to speed up the calculation.*

## 6. Submitting NWChem job to the cluster using job scheduler

- SGE

[SGE scripts for submitting NWChem jobs](../sge)

- SLURM

[SLURM scripts for submitting NWChem jobs](../slurm)

---

## Example of Bash script for automated compilation

### Red Hat and CentOS

- OpenMPI on Red Hat/CentOS
- Intel MPI on Red Hat/CentOS
- Intel MPI + GPU on Red Hat/CentOS
- MPICH MPI on Red Hat/CentOS
- MPICH MPI + GPU on Red Hat/CentOS
- MVAPICH2 MPI on Red Hat/CentOS
- MVAPICH2 MPI + GPU on Red Hat/CentOS

### Ubuntu

- [OpenMPI on Ubuntu](install-nwchem-openmpi.md)
- [OpenMPI + GPU on Ubuntu](install-nwchem-openmpi-gpu.md)
- [OpenMPI + GPU on AWS Deep Learning Ubuntu AMI](install-nwchem-openmpi-gpu-on-aws-deep-learning-ubuntu.md)

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
