# Install Intel MPI

## Prerequisites

- Basic development tools (`sudo yum group install "Development Tools"`)
- Intel Compilers
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

## Intel MPI

1. Download software installer from https://registrationcenter.intel.com/RegCenter/ComForm.aspx?ProductID=1744.
2. Uncompress the tarball and execute shell file to start installation

```
tar -xvzf l_mpi-rt_2018.2.199.tgz
cd l_mpi-rt_2018.2.199
sudo ./install.sh
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
