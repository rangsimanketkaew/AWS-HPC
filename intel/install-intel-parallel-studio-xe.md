# Install Intel Parallel Studio XE

## FAQ

> Q: Where can I find all Intel products? </br>
> A: https://registrationcenter.intel.com/en/products/
>
> Q: Are they free? </br>
> A: Yes, Intel is so generous. Student, teacher, open-source developer can download Intel Parallel Studio XE in free of charge!

## Prerequisites

- Basic development tools (`sudo yum group install "Development Tools"`)
- root or sudo permission (for installation at global space)

## Installing development tools

- Red Hat/CentOS

```
sudo yum update && sudo yum install wget lsb gcc-c++ expect
```

- Ubuntu

```
sudo apt-get update
sudo apt-get upgrade && sudo apt-get install wget lsb gcc expect
```

## Intel Parallel Studio XE installer

1. Download installer of Intel Parallel Studio XE suite or library from Intel software center

```
wget <package_name>.tgz
```

2. Untar the archive

```
tar –xvf <package_name>.tgz
```

3. Execute bash installer (.sh) and follow the onscreen instruction to complete installation

```
sh ./<package_name>.sh
```

_Installation can take 5 - 20 min, depending on the packages to be installed._

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
