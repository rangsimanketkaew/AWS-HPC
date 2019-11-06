# Create AWS (Virtual) Parallel Cluster

## Parallel Cluster

> FYI: Virtual parallel cluster = Master node + Slave node(s)

_Note that the CnfCluster is obsoleted. If you are currently using CnfCluster, you can start using a new AWS ParallelCluster (pcluster) instead._

## Prerequisites

1. Virtualenv (optional)
2. AWS CLI
3. AWS ParallelCluster

## Let's create the cluster

To create the cluster, you have two ways:

- Launch new cluster with default configuration settings

By default, if no configuration file specified, AWS ParallelCluster will use the default file, `$HOME/.parallelcluster/config`, for all configuration parameters.

```
(pcluster-virtenv) [duff@]$ pcluster create NAME_OF_CLUSTER
```

- Launch new cluster with configure file

```
(pcluster-virtenv) [duff@]$ pcluster create NAME_OF_CLUSTER --config PATH_TO_CONFIG_FILE
```

Creation can take 1 - 30 min. If it is completed successfully (without any error messages), you should see output like thos:

```
Beginning cluster creation for cluster: NAME_OF_CLUSTER
Creating stack named: parallelcluster-NAME_OF_CLUSTER
Status: parallelcluster-NAME_OF_CLUSTER - CREATE_COMPLETE
MasterPublicIP: XXX.XXX.XXX.XXX
ClusterUser: centos
MasterPrivateIP: XXX.XXX.XXX.XXX
```

In addition, you can look at [this page](configure-parallelcluster-config.md) for more details on adjusting `config` file.

## Check the status of existing cluster

- List all existing cluster, for example:

```
(pcluster-virtenv) [duff@]$ pcluster list
c1  CREATE_COMPLETE  2.4.1
c2  CREATE_COMPLETE  2.4.1
c3  CREATE_COMPLETE  2.4.1
c4  CREATE_COMPLETE  2.4.1
```

## Connect to the cluster

Use SSH to connect to the master node of the cluster:

```
(pcluster-virtenv) [duff@]$ chmod 400 .ssh/YOUR_KEY_FILE.pem
(pcluster-virtenv) [duff@]$ pcluster ssh NAME_OF_CLUSTER -i .ssh/YOUR_KEY_FILE.pem
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

## Update the cluster

Update the cluster with the latest change of configuration file:

```
(pcluster-virtenv) [duff@]$ pcluster update NAME_OF_CLUSTER -i .ssh/YOUR_KEY_FILE.pem
```

## More to read
- Calculate the cost for your solution: https://calculator.aws
- Github repo: https://github.com/aws/aws-parallelcluster
- HTML manual: https://docs.aws.amazon.com/parallelcluster/latest/ug/what-is-aws-parallelcluster.html

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
