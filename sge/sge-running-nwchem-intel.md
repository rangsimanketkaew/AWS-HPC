# SGE script for running NWChem on the AWS Parallel Cluster

## Intel Job Script

```
#!/bin/bash

#$ -S /bin/sh
#$ -N JOB_NAME
#$ -cwd
#$ -j y
#$ -m be
#$ -M rangsiman1993@gmail.com
#$ -pe mpi 16
#$ -V
#$ -o nwchem-log
#$ -e nwchem-error

module purge
module load intel/2018_u1 cuda/8.0.61 gcc/6.3.0

cd $SGE_O_WORKDIR

ulimit -c 0
ulimit -s unlimited

export SCRATCH_DIR=/myshared/scratch/nwchem/nwchem.sge${JOB_ID/\/}
if [ ! -d $SCRATCH_DIR ]; then mkdir -p $SCRATCH_DIR; fi

export I_MPI_FABRICS=shm:tmi
export I_MPI_PIN_DOMAIN=omp
export I_MPI_HYDRA_BRANCH_COUNT=-1
export I_MPI_HYDRA_PMI_CONNECT=alltoall

export MPI_ROOT=$I_MPI_ROOT/intel64
export MPICC=$MPI_ROOT/bin/mpiicc
export MPICXX=$MPI_ROOT/bin/mpiicpc
export MPIFC=$MPI_ROOT/bin/mpiifort

export NWCHEM_EXE=/full/path/to/binary/of/nwchem
export NWCHEM_TARGET=LINUX64
export NWCHEM_RESRC=/full/path/to/default.nwchemrc

if [ ! -f ~/.nwchemrc ]; then ln -s $NWCHEM_RESRC ~/.nwchemrc; fi

mpiexec.hydra -PSM2 -n 16 -genv CSP_NG 1 $NWCHEM_EXE \
/full/path/of/input/file.nw > \
/full/path/of/input/file.out
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
