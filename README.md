# CompEnv-AWS-EC2

</br>

<div class="row">
  <div class="column">
    <img src="images/1200px-Amazon_Web_Services_Logo.svg.png" alt="aws-logo" width="300px" 
         margin-left="auto" display="block" margin-right"auto">
  </div>
  <div class="column">
    <img src="images/comp-sci.jpg" alt="comp-sci" width="500" 
         margin-left="auto" display="block" margin-right"auto">
  </div>
</div>

</br>
</br>

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

**Note that these notes should be read from top to bottom.**

## Getting started and quick launching AWS EC2 instance

- [What is AWS EC2?](https://www.google.com/search?q=what+is+aws+ec2&rlz=1C1CHBF_enTH823TH823&oq=what+is+AWS+EC2)
- [Creating your first compute node on AWS EC2](aws/create-aws-ec2-instance.md)
- [Youtube: Instances In AWS | How To Create AWS EC2 Instance | AWS EC2 Tutorial | Edureka](https://www.youtube.com/watch?v=FXvlq89Ph_4) and complete video list is [here](https://www.youtube.com/playlist?list=PL9ooVrP1hQOFWxRJcGdCot7AgJu29SVV3).

## Initial creation and setup of AWS EC2 instance

1. Go to https://aws.amazon.com/ec2/ and sign in to the AWS EC2 console with your Account ID, IAM username, and password
2. Go to `Service` and click `EC2 dashboard` and select Launch instance
3. Select an Amazon Machine Image (AMI)
   - Choosing Linux distribution (deliver method by Amazon Machine Image (AMI))
     - [Red Hat 8 with HVM](https://aws.amazon.com/marketplace/pp/B07T4SQ5RZ?qid=1572577369870&sr=0-1&ref_=srh_res_product_title)
     - [Red Hat 7.2 with HVM](https://aws.amazon.com/marketplace/pp/B019NS7T5I?qid=1572577369870&sr=0-2&ref_=srh_res_product_title)
     - [CentOS 7 with HVM](https://aws.amazon.com/marketplace/pp/Centosorg-CentOS-7-x8664-with-Updates-HVM/B00O7WM7QW)
       - [Setting up CentOS 7](linux/setup-centos-7.md)
       - [Installing basic development tools](linux/install-basic-tools-centos.md)
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

## Creating AMI image (optional)

- Create AMI image
- Launch new instance using created AMI image
- Launch new parallel cluster using created AMI image

## Creating cloud cluster

- [Installing AWS CLI](aws/install-aws-cli.md)
- [Installing AWS ParallelCluster](aws/install-aws-parallel-cluster.md)
- [Installing AWS CloudFormation Helper Scripts](aws/install-aws-cloudformation-helper-scripts.md)
- [Creating virtual parallel cluster](aws/create-aws-parallel-cluster.md)
- [Creating virtual parallel cluster with user-adjusted configuration](aws/configure-aws-parallel-cluster.md)
- Resizing worker nodes

## Getting started parallel cluster

- [First landing on the cluster](aws/first-landing-on-the-cluster.md)
- [Measuring computer power using LINPACK (benchmarking)](misc/measure-computer-power.md) (optional)
- Evaluating the performance of parallel file system using IOR (optional)

## Using job scheduler

- SGE
  - [SGE job scheduling](sge/sge-job-scheduling.md)
  - [Basic SGE command usage](sge/sge-basic-usage.md)
  - [Preparing and submitting the job on the cluster](sge/sge-prepare-job-script.md)
  - [Intel job script for running NWChem](sge/sge-running-nwchem-intel.md)
- AWSBATCH
- SLURM
  - [Common command and parallel code](slurm)
  - [Script for running with distributed memory](slurm/slurm-nwchem-distributed-casper.sh)
  - [Script for running with hybrid memory](slurm/slurm-nwchem-hybrid-casper.sh)
- TORQUE

## Installing development tools

- GNU and GCC compilers
- [Intel Compiler](intel/install-intel-compiler.md)
- [Intel Math Kernel Library (MKL)](intel/install-intel-mkl.md)
- ATLAS
- BLAS
- LAPACK
- ScaLAPACK

## Installing message passing interface (MPI) library

- [Intel MPI](install-intel-library.md)
- [OpenMPI](mpi/install-openmpi.md)
- MPICH
- MVAPICH2

## Installing GPU-accelerated library

- [NVIDIA driver](gpu/install-nvidia-driver-and-cuda-toolkit.md)
- [CUDA toolkit](gpu/install-nvidia-driver-and-cuda-toolkit.md)

## Installing computational chemistry software

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

## Useful notes

- [Useful AWS CLI commands](notes/useful-aws-cli-commands.md)
- [Copying file and folder between local computer and AWS instance](notes/copy-file-between-computers.md)

## More to read

If you are interested in AWS cloud cluster service, then I recommend you to read or visit the following website, blog, and forum!

- https://aws-parallelcluster.readthedocs.io/en/latest/
- https://github.com/aws/aws-parallelcluster

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
