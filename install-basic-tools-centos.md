#!/bin/bash

sudo yum install -y -q -e 0 centos-release-scl
sudo yum install -y -q -e 0 devtoolset-8
sudo yum install -y -q -e 0 devtoolset-8-libasan-devel devtoolset-8-libubsan-devel
source /opt/rh/devtoolset-8/enable
echo "source /opt/rh/devtoolset-8/enable > /dev/null" | sudo tee --append /etc/bashrc
sudo yum install -y -q -e 0 hostname
sudo yum install -y -q -e 0 wget
sudo yum install -y -q -e 0 unzip
sudo yum install -y -q -e 0 m4
sudo yum install -y -q -e 0 epel-release
sudo yum install -y -q -e 0 bc
sudo yum install -y -q -e 0 jq
sudo yum install -y -q -e 0 autoconf dh-autoreconf
sudo yum install -y -q -e 0 make
sudo yum install -y -q -e 0 cmake3
sudo ln -s /usr/bin/cmake3 /usr/bin/cmake
sudo yum install -y -q -e 0 git
sudo yum install -y -q -e 0 libxml2-python.x86_64
sudo yum install -y -q -e 0 python python36 python-devel python36-devel python-setuptools python36-setuptools python-pip python36-pip
sudo yum install -y -q -e 0 cppcheck
sudo yum install -y -q -e 0 glibc-static
sudo yum install -y -q -e 0 libhugetlbfs libhugetlbfs-devel libhugetlbfs-utils
sudo yum install -y -q -e 0 irqbalance
sudo yum install -y -q -e 0 mesa-libGLU libXcursor libXft libXinerama
sudo yum install -y -q -e 0 atop
sudo yum install -y -q -e 0 htop
sudo yum install -y -q -e 0 GMT
sudo yum install -y -q -e 0 ghostscript
sudo yum groupinstall -y -q -e 0 "Development Tools"
