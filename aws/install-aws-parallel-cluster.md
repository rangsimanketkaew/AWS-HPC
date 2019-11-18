# Install and Configure AWS ParallelCluster

## Prerequisites

1. AWS CLI
2. Virtualenv (optional)

## Let's start!

1. Install aws-parallelcluster

```
(pcluster-virtenv) [duff]$ pip install aws-parallelcluster
...
... output snipped...
...
Successfully installed aws-parallelcluster-2.4.1 ...
```

You can check if aws-parallelcluster is installed successfully.

```
(pcluster-virtenv) [duff]$ pcluster version
2.4.1
```

2. Next, set configure settings for launching the cluster

```
(pcluster-virtenv) [duff@]$ pcluster configure
Cluster Template [default]:
AWS Access Key ID []:  YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key ID []: YOUR_AWS_SECRET_ACCESS_KEY_ID
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

So far, there should be a small file called `config` created at `$HOME/.parallelcluster/config`. ParallelCluster uses this file by default for all configuration parameters for creating a cluster.

3. Now you can try creating the cluster using `pcluster` with `create` option.

```
(pcluster-virtenv) [duff]$ pcluster create mycluster
...
... output snipped...
...
```

*Note that this can take 30 second - up to 30 min depending on how configuration parameters are complicated.*

4. Optional: to create a serious cluster for production work, you may have to edit/adjust the `config` file. You can create a new config file and change the location of the config file via the `--config` command option, e.g.

```
(pcluster-virtenv) [duff]$ pcluster create mycluster --config $HOME/.parallelcluster/my_new_config
```

An example configuration file can be found at [configure-aws-parallel-cluster](configure-aws-parallel-cluster.md).

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com

