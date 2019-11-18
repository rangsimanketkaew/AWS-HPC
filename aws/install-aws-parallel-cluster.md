# Install and Configure AWS ParallelCluster

## Prerequisites

1. AWS CLI
2. Virtualenv (optional)

- Install aws-parallelcluster

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

- Next, set configure settings for launching the cluster

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

The `config` file will be created at `$HOME/.parallelcluster/config`.

- Now you can try creating the cluster using `create` option and pcluster will take configure settings from the config file.

```
pcluster create mycluster
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com

