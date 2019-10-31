# AWS Parallel Cluster Configuration

## Example of config file

1. Create new file in a hidden folder at your home directory, for example:

```
cd $HOME
vi .parallelcluster/config_new
```

2. Append the following codes to config_new file and change the value for each configuration to your need.

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
##custom_ami =
master_instance_type = c5.xlarge
compute_instance_type = c5.4xlarge
master_root_volume_size = 30
compute_root_volume_size = 30
initial_queue_size = 2
max_queue_size = 8
min_queue_size = 0
maintain_initial_size = false
scheduler = sge
cluster_type = spot
placement_group = DYNAMIC
placement = cluster
ebs_settings = shared
fsx_settings = fs
vpc_settings = public
spot_bid_percentage=
spot_price=

[ebs shared]
shared_dir = neweq_shared
volume_type = st1
volume_size = 500

[fsx fs]
shared_dir = /fsx
storage_capacity = 3600
##imported_file_chunk_size = 1024

[vpc public]
vpc_id = vpc-XXXXXXXX
master_subnet_id = subnet-XXXXXXXX

[aliases]
ssh = ssh {CFN_USER}@{MASTER_IP} {ARGS}

[scailing custom]
scaledown_idletime = 1
```

Note that above config is adapted from the original config file provided by [EDGE's user guide](http://usr.dial3343.org/en/master/chapters/setup/cloud.html#sec-cloud-parallel-cluster).

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
