# Setup AWS Virtual Parallel Cluster

Virtual parallel cluster = Master node + Slave node(s)

## Parallel Cluster

_Note that the CnfCluster is obsoleted. If you are currently using CnfCluster, you can start using a new AWS ParallelCluster (pcluster) instead._

## Create virtual environment

```
[duff]$ virtualenv ~/Envs/pcluster-virtenv
[duff]$ source ~/Envs/pcluster-virtenv/bin/activate
(pcluster-virtenv) [duff]$ 
```

## Configure aws credential

```
(pcluster-virtenv) [duff]$ pip install --upgrade awscli
(pcluster-virtenv) [duff@]$ aws configure
AWS Access Key ID []: <aws_access_key>
AWS Secret Access Key []: <aws_secret_access_key>
Default region name []: us-east-1
Default output format []: json
(pcluster-virtenv) [duff]$ aws s3 mb s3://duff-parallelcluster
make_bucket: duff-parallelcluster 
```

## Configure parallelcluster credential

- Install aws-parallelcluster

```
(pcluster-virtenv) [duff]$ pip install aws-parallelcluster
...
... output snipped...
...
Successfully installed aws-parallelcluster-2.4.1 ...
```

- When it's completed, let's configure the cluster

```
(pcluster-virtenv) [duff@]$ pcluster configure
Cluster Template [default]:
AWS Access Key ID []:  <blank>
AWS Secret Access Key ID []: <blank>
Acceptable Values for AWS Region ID:
    us-east-1
    us-east-2
    us-west-1
    us-west-2
    eu-west-3
    eu-west-2
    eu-west-1
    ca-central-1
    eu-central-1
    ap-northeast-2
    ap-northeast-1
    sa-east-1
    ap-south-1
    ap-southeast-1
    ap-southeast-2
AWS Region ID []: us-east-1
VPC Name [public]:
Acceptable Values for Key Name: <blank>
    duff_key_us-east-1
Key Name []: duff_key_us-east-1
Acceptable Values for VPC ID:
    vpc-12345678901234567
    vpc-abcdefghigjlmnopq
VPC ID []: vpc-abcdefghigjlmnopq
Acceptable Values for Master Subnet ID:
    subnet-abcdefghigjlmnop1
    subnet-abcdefghigjlmnop2
    subnet-abcdefghigjlmnop3
    subnet-abcdefghigjlmnop4
    subnet-abcdefghigjlmnop5
    subnet-abcdefghigjlmnop6
Master Subnet ID []: subnet-abcdefghigjlmnop1
```

## Create the cluster

- Launch new cluster with default settings offered by AWS

By default, AWS ParallelCluster uses the file ~/.parallelcluster/config for all configuration parameters.

```
(pcluster-virtenv) [duff@]$ pcluster create NAME_OF_CLUSTER
```

- Launch new cluster with configure file

```
(pcluster-virtenv) [duff@]$ pcluster create NAME_OF_CLUSTER --config PATH_TO_CONFIG_FILE
Beginning cluster creation for cluster: NAME_OF_CLUSTER
Creating stack named: parallelcluster-NAME_OF_CLUSTER
Status: parallelcluster-NAME_OF_CLUSTER - CREATE_COMPLETE
MasterPublicIP: XXX.XXX.XXX.XXX
ClusterUser: centos
MasterPrivateIP: XXX.XXX.XXX.XXX
```

Example of **config** file is also available.

Documentation on configuration can be found at [this website](https://docs.aws.amazon.com/parallelcluster/latest/ug/configuration.html).

## Check the status of existing cluster

- List all existing cluster, for example:

```
(pcluster-virtenv) [duff@]$ pcluster list
hello-cluster1
```

## Connect to the cluster

Use SSH to connect to the master node of the cluster:

```
(pcluster-virtenv) [duff@]$ chmod 400 .ssh/YOUR_KEY_FILE.pem
(pcluster-virtenv) [duff@]$ pcluster ssh NAME_OF_CLUSTER -i .ssh/YOUR_KEY_FILE.pem
```

Update the cluster with the latest change of configuration file:

```
(pcluster-virtenv) [duff@]$ pcluster update NAME_OF_CLUSTER -i .ssh/YOUR_KEY_FILE.pem
```

Normal output should look like this:

```
The authenticity of host '35.153.251.20 (35.153.251.20)' can't be established.
ECDSA key fingerprint is SHA256:u9+A0i6Y94JcRGYW8eyi5e4N+iiNtpPTPAwPY5PQcWk.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '35.153.251.20' (ECDSA) to the list of known hosts.
Last login: Sun Nov 11 20:12:12 2018

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2018.03-release-notes/
```

## Show how many compute nodes are running out there

What is you use SGE as a job scheduler, you can use qhost commmand to show all running compute nodes

```
[ec2-user@ip-123-45-6-78 ~]$ qhost
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.02    3.7G  156.2M     0.0     0.0
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.02    3.7G  156.8M     0.0     0.0
```

## Testing

1. Try submitting a simple hostname job that will show the AutoScaling feature of ParallelCluster using the mpirun command, for example:

```
[ec2-user@ip-172-31-0-14 ~]$ echo /usr/lib64/openmpi/bin/mpirun hostname | qsub -pe mpi 16
Your job 1 ("STDIN") has been submitted
```

2. Use qstat command to show the status of a submitted job:

```
[ec2-user@ip-172-31-0-14 ~]$ qstat
job-ID  prior   name       user         state submit/start at     queue           slots ja-task-ID
--------------------------------------------------------------------------------------------------
      1 0.00000 STDIN      ec2-user     qw    11/11/2018 20:25:38                 16
```

A few minute later AWS AutoScailing will launch the instance automatically.

```
[ec2-user@ip-172-31-0-14 ~]$ qhost
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
ip-172-31-0-XX          lx-amd64        2    1    1    2  0.11    3.7G  189.0M     0.0     0.0
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.29    3.7G  189.2M     0.0     0.0
ip-172-31-14-XX         lx-amd64        2    1    1    2  0.11    3.7G  189.1M     0.0     0.0
ip-172-31-2-XX          lx-amd64        2    1    1    2  0.06    3.7G  189.4M     0.0     0.0
ip-172-31-3-XXX         lx-amd64        2    1    1    2  0.11    3.7G  185.5M     0.0     0.0
ip-172-31-4-XXX         lx-amd64        2    1    1    2  0.11    3.7G  186.2M     0.0     0.0
ip-172-31-5-XXX         lx-amd64        2    1    1    2  0.08    3.7G  188.9M     0.0     0.0
ip-172-31-5-XX          lx-amd64        2    1    1    2  0.08    3.7G  189.0M     0.0     0.0
```

Then, after 10 minutes, when the job is completed, the AutoScailing will terminate those compute nodes for you.

```
[ec2-user@ip-172-31-0-14 ~]$ qhost
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
```

_AutoScailing is a feature that can build and terminate the virtual instance and request CPU cores on-the-fly (whenever you need)._

## More to read
- Calculate the cost for your solution: https://calculator.aws
- Github repo: https://github.com/aws/aws-parallelcluster
- HTML manual: https://docs.aws.amazon.com/parallelcluster/latest/ug/what-is-aws-parallelcluster.html

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
