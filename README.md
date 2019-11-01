# CompEnv-AWS-EC2

![aws-logo](images/1200px-Amazon_Web_Services_Logo.svg.png)

**Computational environment and Computational Chemistry on AWS EC2 platform.**

This Github repository provides all information about high performance computing (HPC) and cluster management tools for AWS Parallel Cloud Cluster services: EC2, ParallelCluster, CloudFormation, EFX, S3, and AutoScaling features.

## Resources

- Initial setup of AWS EC2 instance
  - [AWS documentation](https://aws-parallelcluster.readthedocs.io/en/latest/) 
- Getting started instance and compute node
  - [Creating your first compute node on AWS EC2](create-instance-on-aws-ec2.md)
  - Choosing Linux distribution (deliver method by Amazon Machine Image (AMI))
    - [Red Hat 8 with HVM](https://aws.amazon.com/marketplace/pp/B07T4SQ5RZ?qid=1572577369870&sr=0-1&ref_=srh_res_product_title)
    - [Red Hat 7.2 with HVM](https://aws.amazon.com/marketplace/pp/B019NS7T5I?qid=1572577369870&sr=0-2&ref_=srh_res_product_title)
    - [CentOS 7 with HVM](https://aws.amazon.com/marketplace/pp/Centosorg-CentOS-7-x8664-with-Updates-HVM/B00O7WM7QW)
      - [Setting up CentOS 7](setup-centos-7.md)
      - [Installing basic development tools](install-basic-tools-centos.md)
    - [Ubuntu 19.04](https://aws.amazon.com/marketplace/pp/B07RF8N2K2?qid=1572577464695&sr=0-9&ref_=srh_res_product_title)
    - [Ubuntu 18.04 LTS](https://aws.amazon.com/marketplace/pp/B07CQ33QKV?qid=1572577464695&sr=0-1&ref_=srh_res_product_title)
    - [Ubuntu 16.04 LTS](https://aws.amazon.com/marketplace/pp/B01JBL2M0O?qid=1572577464695&sr=0-2&ref_=srh_res_product_title)
- Creating cloud cluster
  - [Installing AWS CLI](install-aws-cli.md)
  - [Installing AWS ParallelCluster](install-aws-parallelcluster.md)
  - [Creating virtual parallel cluster](create-parallel-cluster.md)
  - Configuring AWS ParallelCluster: master and worker nodes
- Job scheduler
  - SGE
    - [SGE job scheduling](sge-job-scheduling.md)
    - [Basic SGE command usage](sge-basic-usage.md)
    - [Preparing and submitting the job on the cluster](sge-prepare-job-script.md)
  - AWSBATCH
  - SLURM
  - TORQUE
- Benchmarking performance of cluster
  - Measuring computer power using LINPACK
  - Evaluating the performance of parallel file system using IOR
- Installing development tools
  - GNU and GCC compilers
  - [Intel Compiler](install-intel-library.md)
  - [Intel Math Kernel Library (MKL)](install-intel-library.md)
  - ATLAS
  - BLAS
  - LAPACK
  - ScaLAPACK
- Installing massage passing interface (MPI) library
  - [Intel MPI](install-intel-library.md)
  - [OpenMPI](install-openmpi.md)
  - MPICH
  - MVAPICH
- Installing accelerated library
  - [NVIDIA driver](install-nvidia-driver-and-cuda-toolkit.md)
  - [CUDA toolkit](install-nvidia-driver-and-cuda-toolkit.md)
- Installing chemistry program packages
  - [NWChem](./nwchem)
    - [Installing with OpenMPI](nwchem/install-nwchem-openmpi.md)
    - [Installing with OpenMPI with GPU CUDA](nwchem/install-nwchem-openmpi-gpu.md)
    - [Note on NWChem compilation](nwchem/note-on-nwchem.md)
  - ORCA
  - Gromacs
  - LAMMPS

## More to read

I strongly recommend the following website/blog/forum!

- https://aws-parallelcluster.readthedocs.io/en/latest/
- https://github.com/aws/aws-parallelcluster

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
