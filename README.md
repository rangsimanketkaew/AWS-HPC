# CompEnv-AWS-EC2

![aws-logo](images/1200px-Amazon_Web_Services_Logo.svg.png)

**Computational environment and Computational Chemistry on AWS EC2 platform.**

This Github repository provides information about high performance computing (HPC) and cluster management tools on AWS Cloud Cluster services. Also, it will tell how to leverage AWS services related to cloud cluster as follows:

- Amazon Elastic Cloud Cluster (EC2)
- Amazon ParallelCluster
- Amazon CloudFormation
- Amazon EC2 Fleet
- Amazon Elastic Block Store (EBS)
- Amazon Elastic File System (EFS)
- Amazon Simple Storage Service (S3)
- Amazon AutoScaling

## Getting started and quick launching AWS EC2 instance

- [What is AWS EC2?](https://www.google.com/search?q=what+is+aws+ec2&rlz=1C1CHBF_enTH823TH823&oq=what+is+AWS+EC2)
- [Creating your first compute node on AWS EC2](create-aws-ec2-instance.md)

## Initial creation and setup of AWS EC2 instance

1. Go to https://aws.amazon.com/ec2/ and sign in to the AWS EC2 console with your Account ID, IAM username, and password
2. Go to `Service` and click `EC2 dashboard` and select Launch instance
3. Select an Amazon Machine Image (AMI)
   - Choosing Linux distribution (deliver method by Amazon Machine Image (AMI))
     - [Red Hat 8 with HVM](https://aws.amazon.com/marketplace/pp/B07T4SQ5RZ?qid=1572577369870&sr=0-1&ref_=srh_res_product_title)
     - [Red Hat 7.2 with HVM](https://aws.amazon.com/marketplace/pp/B019NS7T5I?qid=1572577369870&sr=0-2&ref_=srh_res_product_title)
     - [CentOS 7 with HVM](https://aws.amazon.com/marketplace/pp/Centosorg-CentOS-7-x8664-with-Updates-HVM/B00O7WM7QW)
       - [Setting up CentOS 7](setup-centos-7.md)
       - [Installing basic development tools](install-basic-tools-centos.md)
     - [Ubuntu 19.04](https://aws.amazon.com/marketplace/pp/B07RF8N2K2?qid=1572577464695&sr=0-9&ref_=srh_res_product_title)
     - [Ubuntu 18.04 LTS](https://aws.amazon.com/marketplace/pp/B07CQ33QKV?qid=1572577464695&sr=0-1&ref_=srh_res_product_title)
     - [Ubuntu 16.04 LTS](https://aws.amazon.com/marketplace/pp/B01JBL2M0O?qid=1572577464695&sr=0-2&ref_=srh_res_product_title)
4. Select an instance type
5. Configure instance details (optional)
6. Add and configure storage (optional)
7. Add tag (optional)
8. Set a security group (optional)
9. Launch instance
10. Create a new key pair or choose an existing key pair

**Let's keep in mind downloading a new created key pair (.pem) before launching instance as you will not be able to download it again.**

## Creating cloud cluster

- [Installing AWS CLI](install-aws-cli.md)
- [Installing AWS ParallelCluster](install-aws-parallelcluster.md)
- [Creating virtual parallel cluster](create-parallel-cluster.md)
- [Creating virtual parallel cluster with user-adjusted configuration](configure-parallelcluster-config.md)
- Resizing worker nodes

## Job scheduler

- SGE
  - [SGE job scheduling](sge-job-scheduling.md)
  - [Basic SGE command usage](sge-basic-usage.md)
  - [Preparing and submitting the job on the cluster](sge-prepare-job-script.md)
- AWSBATCH
- SLURM
- TORQUE

## Benchmarking performance of cluster

- Measuring computer power using LINPACK
- Evaluating the performance of parallel file system using IOR

## Installing development tools

- GNU and GCC compilers
- [Intel Compiler](install-intel-library.md)
- [Intel Math Kernel Library (MKL)](install-intel-library.md)
- ATLAS
- BLAS
- LAPACK
- ScaLAPACK

## Installing massage passing interface (MPI) library

- [Intel MPI](install-intel-library.md)
- [OpenMPI](install-openmpi.md)
- MPICH
- MVAPICH

## Installing accelerated library

- [NVIDIA driver](install-nvidia-driver-and-cuda-toolkit.md)
- [CUDA toolkit](install-nvidia-driver-and-cuda-toolkit.md)

## Installing chemistry program packages

- [NWChem](./nwchem)
  - [Installing with OpenMPI](nwchem/install-nwchem-openmpi.md)
  - [Installing with OpenMPI with GPU CUDA](nwchem/install-nwchem-openmpi-gpu.md)
  - [Note on NWChem compilation](nwchem/note-on-nwchem.md)
- ORCA
- GAMESS (US)
- PSI4
- OpenMolcas
- CP2K
- Gromacs
- LAMMPS

## More to read

I strongly recommend the following website/blog/forum!

- https://aws-parallelcluster.readthedocs.io/en/latest/
- https://github.com/aws/aws-parallelcluster

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
