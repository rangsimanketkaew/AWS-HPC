# SLURM parallel code

## Common SLURM commands

Command	 | Definition
---------|-----------
sbatch	 | Submits job scripts into system for execution (queued)
scancel	 | Cancels a job
scontrol |Used to display Slurm state, several options only available to root
sinfo	   | Display state of partitions and nodes
squeue	 | Display state of jobs
salloc	 | Submit a job for execution, or initiate job in real time
sacct    | Displays accounting data and status for all jobs

## Specifying resources commands

Syntax | Meaning
-------|---------
--ntasks=<number>	           | Number of processes to run (default is 1)
--mem=<number>	             | Total memory (single node)
--mem-per-cpu=<number>	     | Memory per processor core
--constraint=<attribute>	   | Node property to request (e.g. avx, IB)
--partition=<partition_name> | Request specified partition/queue

## MPI only application

```
#!/bin/bash -l
#SBATCH -J ParallelJob
#SBATCH -n 128
#SBATCH -c 1
#SBATCH --time=0-01:00:00
#SBATCH -p batch

module load toolchain/intel
mpirun -n $SLURM_NTASKS [argv] program_executable [argv] ...
```

## OpenMPI only application

```
#!/bin/bash -l
#SBATCH -J ThreadedJob
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 28
#SBATCH --time=0-01:00:00
#SBATCH -p batch

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun -n $SLURM_NTASKS [argv] program_executable [argv] ...
```

## Multi-node hybrid application (MPI+OpenMP)

```
#!/bin/bash -l
#SBATCH -J HybridParallelJob
#SBATCH -N 10
#SBATCH --ntasks-per-node=1
#SBATCH -c 28
#SBATCH --time=0-01:00:00
#SBATCH -p batch

module load toolchain/intel
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun -n $SLURM_NTASKS [argv] program_executable [argv] ...
```

## Multi-node multi-GPU MPI application

```
#!/bin/bash -l
#SBATCH -J GPUJob
#SBATCH -N 4
#SBATCH --ntasks-per-socket=4
#SBATCH -c 7
#SBATCH --gres=gpu:4
#SBATCH --time=0-01:00:00
#SBATCH -p gpu

module load toolchain/intel
module load system/CUDA

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun -n $SLURM_NTASKS [argv] program_executable [argv] ...
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
