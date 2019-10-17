# Job Scheduling

## List of compute nodes

```
// For SGE scheduler
$ qconf -sel | awk -F. '{print $1}' &> hostfile

// For SLURM workload manager
$ sinfo -N | grep compute | awk '{print $1}' &> hostfile
```

## Prepare script

### SGE script

```
#!/bin/sh
#$ -cwd
#$ -j y

# Executable
EXE=/home/centos/hpcg/bin/xhpcg_skx

# MPI Settings
source /shared/opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64
source /shared/opt/intel/impi/2018.2.199/bin64/mpivars.sh intel64 

# Fabrics Settings
export I_MPI_FABRICS=shm:tcp

# Launch MPI application
mpirun -np 4 -ppn 1 -machinefile hostfile -genv KMP_AFFINITY="granularity=fine,compact,1,0" $EXE
```

### SLURM script

```
#!/bin/bash
#SBATCH -N 4
#SBATCH -t 00:02:00 #wall time limit

# Executable
EXE=/home/centos/hpcg/bin/xhpcg_skx

# MPI Settings
source /shared/opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64
source /shared/opt/intel/impi/2018.2.199/bin64/mpivars.sh intel64
 
# Fabrics Settings
export I_MPI_FABRICS=shm:tcp

# Launch MPI application
mpirun -np 4 -ppn 1 -machinefile hostfile -genv KMP_AFFINITY="granularity=fine,compact,1,0" $EXE
```

## Submitting the job

```
// For SGE scheduler
$ qsub job.sh

// For Slurm workload manager
$ sbatch job.sh
```

