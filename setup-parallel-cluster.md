# Setup AWS Parallel Cluster

# CnfCluster


# Parallel Cluster

_Note that the CnfCluster is obsoleted. If you are currently using CnfCluster, you can start using a new AWS ParallelCluster (pcluster) instead._


## Configure aws credential

```
aws configure
```

## Configure parallelcluster credential

```
pcluster configure
```

## Create the cluster

```
pcluster create NAME_OF_CLUSTER
```

## Connect to the cluster

```
chmod 400 .ssh/YOUR_KEY_FILE.pem
pcluster ssh NAME_OF_CLUSTER -i .ssh/YOUR_KEY_FILE.pem
```

## More to read:
- Github repo: https://github.com/aws/aws-parallelcluster
- HTML manual: https://docs.aws.amazon.com/parallelcluster/latest/ug/what-is-aws-parallelcluster.html

