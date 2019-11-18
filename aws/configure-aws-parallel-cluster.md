# Configuration of AWS Parallel Cluster

## Prerequisite

Before creating the parallel cluster, you must install the following tools:

- AWS CLI
- AWS ParallelCluster

> FYI: If both AWS CLI and ParallelCluster are installed successfully, normally there must be two configuration files at `$HOME/.aws/config` and at `$HOME/.parallelcluster/config`, respectively.

## Step-by-step configuration (or reconfiguration) of AWS ParallelCluster

1. Create a new configuration file, for example, called `config_new`, in a hidden `.parallelcluster` folder in your home directory, like this:

```
cd $HOME
vi .parallelcluster/config_new
```

2. Append the following codes to the `config_new` file and change the configuration parameter and value to your need.

```
[global]
cluster_template = default
update_check = true
sanity_check = true

[aws]
aws_region_name = us-east-1

[cluster default]
key_name = aws_parallel_cluster
base_os = centos7
##custom_ami = NONE
master_instance_type = c5.large
compute_instance_type = c5.4xlarge
initial_queue_size = 0
master_root_volume_size = 30
compute_root_volume_size = 30
max_queue_size = 8
min_queue_size = 0
maintain_initial_size = true
scheduler = sge
cluster_type = spot
placement_group = DYNAMIC
placement = cluster
vpc_settings = public
ebs_settings = shared
##fsx_settings = fs
##spot_price=0.5

[vpc public]
vpc_id = vpc-XXXXXXXX
master_subnet_id = subnet-XXXXXXXX

[ebs shared]
shared_dir = myshared
volume_type = st1
volume_size = 500

##[fsx fs]
##shared_dir = /fsx
##storage_capacity = 3600
##imported_file_chunk_size = 1024

[aliases]
ssh = ssh {CFN_USER}@{MASTER_IP} {ARGS}

[scaling custom]
scaledown_idletime = 1
```

> Note 1: the `config_new` undoubtedly works for my cluster, but it might not work for you. Therefore, you should check if the value of each configuration parameter is suitable with your system. </br>
> Note 2: Adapted from the original config file provided by [EDGE's user guide](http://usr.dial3343.org/en/master/chapters/setup/cloud.html#sec-cloud-parallel-cluster).

3. You can now launch a new cluster using this config_new file, for example:

```
cd $HOME
pcluster create NAME_OF_CLUSTER --config .parallelcluster/config_new
```

This step can take 1 - 30 min depending on configuration parameters.

## More to read

I strongly recommand you to read the documentation before creating a serious cluster.

Official AWS documentation on configuration of parallel cluster can be found at https://docs.aws.amazon.com/parallelcluster/latest/ug/configuration.html.

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
