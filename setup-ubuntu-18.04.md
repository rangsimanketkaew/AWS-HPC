# Setup Ubuntu 18.04 on AWS EC2

## Pre-built Ubuntu 18.04 LTS image

This is the Official CentOS 7 x86_64 HVM image that has been built with a minimal profile, suitable for use in HVM instance types only. The image contains just enough packages to run within AWS, bring up an SSH Server and allow users to login. Please note that this is the default CentOS-7 image that we recommend everyone uses. It contains packages that are updated at points in time to include critical security updates.

## Install basic development tools

1. Change root password: `sudo passwd root`
2. Update packages: `sudo yum update`
3. Install development tools: `sudo yum groupinstall "Development Tools"`
4. Install Python 2 and Python 3: `sudo yum install python-devel python3-devel"
5. Install `wget` and `locate`: `sudo yum install wget mlocate`

## Contact 

Rangsiman Ketkaew - rangsiman1993@gmail.com
