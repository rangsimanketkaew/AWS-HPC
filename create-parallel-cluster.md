# Create AWS (Virtual) Parallel Cluster

## Parallel Cluster

FYI: Virtual parallel cluster = Master node + Slave node(s)

_Note that the CnfCluster is obsoleted. If you are currently using CnfCluster, you can start using a new AWS ParallelCluster (pcluster) instead._

## Prerequisites

1. Virtualenv (optional)
2. AWS CLI
3. AWS ParallelCluster

## Let's create the cluster

- Launch new cluster with default settings offered by AWS

By default, AWS ParallelCluster uses the file `~/.parallelcluster/config` for all configuration parameters.

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

Documentation on configuration can be found at [this website](https://docs.aws.amazon.com/parallelcluster/latest/ug/configuration.html).

In addition, you can look at [this page](configure-parallelcluster-config.md) for more details on adjusting `config` file.

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
The authenticity of host 'xxx.xxx.xxx.xxx (xxx.xxx.xxx.xxx)' can't be established.
ECDSA key fingerprint is SHA256:u9+AXXXXXXXXJcRGYW8eyi5e4N+iiNtpPTXXXXXXXXXXX.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'xxx.xxx.xxx.xxx' (ECDSA) to the list of known hosts.
Last login: XXX XX 20:12:12 2019

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2018.03-release-notes/
```

## Show how many compute nodes are running out there

What is you use SGE as a job scheduler, you can use `qhost` commmand to show all running compute nodes

```
[ec2-user@ip-172-31-0-14 ~]$ qhost
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.02    3.7G  156.2M     0.0     0.0
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.02    3.7G  156.8M     0.0     0.0
```

## Testing

1. Create a file called hello_job.sh

```
#!/bin/bash
sleep 30
echo "Hello World from $(hostname)"
```

2. Submit a simple `hello_job.sh` job that will show the AutoScaling feature of ParallelCluster using the SGE, for example:

```
[ec2-user@ip-172-31-0-14 ~]$ qsub -pe mpi 16 hello_job.sh
Your job 1 ("hello_job.sh") has been submitted
```

3. Use `qstat` command to show the status of a submitted job:

```
[ec2-user@ip-172-31-0-14 ~]$ qstat
job-ID  prior   name        user         state submit/start at     queue           slots ja-task-ID
---------------------------------------------------------------------------------------------------
      1 0.55500 hello_job.s ec2-user     r     31/10/2019 20:25:38   XXX           16
```

A few minute later AWS AutoScaling will launch the instance automatically.

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

Then, after 10 minutes, when the job is completed, the AutoScaling will terminate those compute nodes for you.

```
[ec2-user@ip-172-31-0-14 ~]$ qhost
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
```

_AutoScaling is a feature that can build and terminate the virtual instance and request CPU cores on-the-fly (whenever you need)._

## More to read
- Calculate the cost for your solution: https://calculator.aws
- Github repo: https://github.com/aws/aws-parallelcluster
- HTML manual: https://docs.aws.amazon.com/parallelcluster/latest/ug/what-is-aws-parallelcluster.html

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
