# First landing on the cluster

## Show how many compute nodes are running out there

Suppose that you are using SGE as a job scheduler, you can use `qhost` command to show all running compute nodes

```
[ec2-user@ip-172-31-0-14 ~]$ qhost
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.02    3.7G  156.2M     0.0     0.0
ip-172-31-10-XX         lx-amd64        2    1    1    2  0.02    3.7G  156.8M     0.0     0.0
```

## Running a test job

1. Create a file called `hello_job.sh`

```
#!/bin/bash
sleep 30
echo "Hello World from $(hostname)"
```

2. Submit a simple `hello_job.sh` job that will show the AutoScaling feature of ParallelCluster using SGE job scheduler, for example:

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

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
