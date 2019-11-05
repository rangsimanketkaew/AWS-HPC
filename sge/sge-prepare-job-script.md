# Prepare SGE script

## Running MPI job for testing

1. We will use [IOR, a commonly used HPC benchmarking tool,](http://wiki.lustre.org/IOR) for testing and benchmarking our new created cluster. First of all, create a Bash file called `install_IOR.sh` and then add the following scripts into the file. Suppose that master and compute nodes share the same space at `/shared` directory.

```
#!/bin/bash

module purge
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

2. Execute the `install_IOR.sh` on a master node

```
$ sh ./install_IOR.sh
```

3. Then run the IOR by submitting the script called `myjob.sh` using SGE to run across compute node.

```
#!/bin/bash
#$ -V
#$ -cwd
#$ -N myjob
#$ -j Y
#$ -o output_$JOB_ID.out
#$ -e output_$JOB_ID.err
#$ -pe mpi 16

module purge
module load openmpi
mkdir /fsx/ior
OUTPUT=/fsx/ior/test
export PATH=/shared/hpc/performance/ior/bin:$PATH

mpirun -np ${NSLOTS} ior -w -r -B -C -o $OUTPUT -b 5g -a POSIX -i 1 -F -t 4m
```

where 
- -B  Use O_DIRECT to bypass system library caching and directly access the file system. This provides raw file system performance metrics.
- -a  Define the I/O access interface to use. In this case, select POSIX as the method.
- -F  Create one file per process.
- -C Change the task ordering to n+1 ordering for read-back. Use to avoid read cache effects on client processes.
- -b Define the size of the file to create, per process.
- -t  Define the I/O size to use for each read/write operation.

Note that the above testing script will request 16 CPU cores. So you can change it to any suitable integer number like 32, 64, 128, or 256.

4. Run the following command on a master node to submit job on cluster.

```
$ qsub myjob.sh
Your job 1 (myjob") has been submitted
```

5. Example of output file

```
cat output*
```

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

## Credit

https://aws.amazon.com/blogs/storage/building-an-hpc-cluster-with-aws-parallelcluster-and-amazon-fsx-for-lustre/

## Contact 

Rangsiman Ketkaew - rangsiman1993@gmail.com
