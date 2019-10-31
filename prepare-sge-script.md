# Prepare SGE script

## Running MPI job for testing

1. We will use IOR for benchmarking our new created cluster. Create Bash file, add the following scripts into the file, and run it on a master node.

```
#!/bin/bash

# load MPI wrappers
module load openmpi
mkdir -p /shared/hpc/performance/ior
git clone https://github.com/hpc/ior.git
cd ior
git checkout 3.2.1
./bootstrap
./configure --with-mpiio --with-lustre --prefix=/shared/hpc/performance/ior
make
sudo make install
```

2. Then run the IOR by submitting the script using SGE to run across compute node.

```
#!/bin/bash
#$ -V
#$ -cwd
#$ -N myjob
#$ -j Y
#$ -o output_$JOB_ID.out
#$ -e output_$JOB_ID.err
#$ -pe mpi 16

module load openmpi
mkdir /fsx/ior
OUTPUT=/fsx/ior/test
export PATH=/shared/hpc/performance/ior/bin:$PATH

mpirun -np ${NSLOTS} ior -w -r -B -C -o $OUTPUT -b 5g -a POSIX -i 1 -F -t 4m
```

Note that the above testing script will request 16 CPU cores. So you can change it to any suitable integer number like 32, 64, 128, or 256.

## Running NWChem job

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
module load intel*

export NWCHEM_TOP=/usr/local/nwchem-6.8.1
export NWCHEM_TARGET=LINUX64
export exe=$NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem
export OMP_NUM_THREADS=1
export MIC_USE_2MB_BUFFER=16K
export ARMCI_OPENIB_DEVICE=mlx4_0

TEMP=/myshared
if [ -e $TEMP ]; then
        echo "$TEMP exists"
else
        mkdir -p $TEMP
fi

mpirun -genv MV2_ENABLE_AFFINITY 0 -genv OMP_NUM_THREADS 1 -np $NSLOTS $exe \
       INPUT_NW.nw >& \
       OUTPUT_NW.log
```
