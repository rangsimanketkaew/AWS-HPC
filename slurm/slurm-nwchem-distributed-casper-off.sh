#!/bin/bash

#SBATCH --job-name="nwchem"    # Job name
#SBATCH --nodes=2             # Total number of nodes requested
#SBATCH --ntasks=16           # Total number of mpi tasks
#SBATCH --ntasks-per-node=8  # Number of tasks per each node
#SBATCH --cpus-per-task=1     # Total number of CPUs per task
###SBATCH --ntasks-per-core=1  # Number of tasks per each core
###SBATCH --mem-per-cpu=4000    # Memory (in MB)
#SBATCH --time=120:00:00    # Run time (hh:mm:ss)
#SBATCH --partition=chalawan_gpu       # Name of gpu partition
#SBATCH --gres=gpu:1          # Name of the generic consumable resource

# change directory to where input file is

cd ${SLURM_SUBMIT_DIR}

###########################################################
# Edit following 2 lines to match your input and output file

export INPUT_FILE="tce_cuda_opt.nw"
export OUTPUT_FILE="tce_cuda_opt.out"

# Edit following 2 lines in order to adjust the optimal memory (in MB) for your system

export MEMORY_GLBL="2764"
export MEMORY_TTL="3686"

# Edit following line to set scratch root directory

export SCRATCH_DIR_ROOT="/lustre/$USER/scratch"

###########################################################

echo "This job's process 0 host is: " `hostname`

# Set up NWCHEM environment, permanent, and scratch directory

module purge
module load python/2.7
module load cuda/10.1

source /lustre/rangsiman/intel/bin/compilervars.sh intel64
source /lustre/rangsiman/intel/parallel_studio_xe_2019/bin/psxevars.sh intel64
source /lustre/rangsiman/intel/impi/2019.5.281/intel64/bin/mpivars.sh
source /lustre/rangsiman/intel/mkl/bin/mklvars.sh intel64

# The maximum size of core files created (for debugging)

ulimit -c 0
#ulimit -c unlimited

# The maximum stack size

ulimit -s unlimited

# NWChem executable and library

export NWCHEM_EXE="/lustre/rangsiman/nwchem/intel-2019-u5/nwchem-7.0.0-MPI-PR-GPU/nwchem"
export NWCHEM_BASIS_LIBRARY="/lustre/rangsiman/nwchem/nwchem_basis/libraries/"
export NWCHEM_NWPW_LIBRARY="/lustre/rangsiman/nwchem/nwchem_nwpw/libraryps/"
export NWCHEM_CASLIB="/lustre/rangsiman/nwchem/casper/lib/"

# Optimize Intel MPI parallel method

export I_MPI_FABRICS=shm:ofi
export I_MPI_FALLBACK=0
export I_MPI_PIN_DOMAIN=omp
export I_MPI_HYDRA_BRANCH_COUNT=-1
export I_MPI_HYDRA_PMI_CONNECT=alltoall

# ARMCI configuration

export ARMCI_DEFAULT_SHMMAX=8192

# Define permanent_dir, scratch_dir and memory allocation keywords to nwchem input file

export PERMANENT_DIR=$SLURM_SUBMIT_DIR
export MY_SCRDIR=`whoami;date '+date%m.%d.%y_time%H.%M.%S'`
export MY_SCRDIR=`echo $MY_SCRDIR | sed -e 's; ;_;'`

export RUN_FILE="runner_nwchem_${SLURM_JOB_ID}.nw"
cp $INPUT_FILE $RUN_FILE
export SCRATCH_DIR=${SCRATCH_DIR_ROOT}/${MY_SCRDIR}_$$
mkdir -p $SCRATCH_DIR
printf '\n' >> $RUN_FILE
printf '%s %s\n' 'permanent_dir' $PERMANENT_DIR >> $RUN_FILE
printf '%s   %s\n' 'scratch_dir' $SCRATCH_DIR >> $RUN_FILE
printf '%s %s %s %s %s %s\n' 'memory' 'total' $MEMORY_TTL 'mb global' $MEMORY_GLBL 'mb' >> $RUN_FILE

# Start the calculation!
echo &(which mpirun)

mpirun -np $SLURM_NTASKS -ppn $SLURM_TASKS_PER_NODE -genv OMP_NUM_THREADS $SLURM_CPUS_PER_TASK \
        -genv MV2_CPU_BINDING_POLICY hybrid -genv MV2_HYBRID_BINDING_POLICY linear \
        -genv CSP_ASYNC_CONFIG off -genv LD_PRELOAD $NWCHEM_CASLIB/libcasper.so \
        $NWCHEM_EXE ${RUN_FILE} >& ${OUTPUT_FILE}

# Clean up scratch and temporary files.

/bin/rm -r $SCRATCH_DIR
/bin/rm -r $RUN_FILE

echo 'Job is done!'
