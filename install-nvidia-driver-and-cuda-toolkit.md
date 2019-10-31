# Install NVIDIA driver and CUDA toolkit

# Red Hat or Center

*Please note that on the day of this writing I am using Red Hat version 8*

## Step-by-step installation instruction

1. Identify if the GPU is running on your system
```
lspci -vnn | grep VGA
```

or

```
sudo lshw -class display
```

2. Install all development tools, kernel, EPEL repository, and other dependencies:
```
sudo yum update
sudo yum groupinstall "Development Tools"
sudo yum install epel-release
sudo yum install kernel-devel
sudo yum install dkms
```

However, you can install specific kernel-devel version on CentOS by using rpm package manager. First, find and download rpm file of a specific version of library of interest from this website https://centos.pkgs.org, for example, [kernel-devel-3.10.0-1062.1.2.el7.x86_64](https://centos.pkgs.org/7/centos-updates-x86_64/kernel-devel-3.10.0-1062.1.2.el7.x86_64.rpm.html). Then, use following commands for installing kernel-devel:

```
cd /usr/local/src
sudo wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/kernel-devel-3.10.0-1062.1.2.el7.x86_64.rpm
sudo rpm -i kernel-devel-3.10.0-1062.1.2.el7.x86_64.rpm
```

3. Disable **nouveau** by modifying GRUB

```
sudo grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"
```

4. Reboot instance

```
sudo reboot
```

5. Switch off X server

```
sudo systemctl isolate multi-user.target
```

6. Download **CUDA toolkit installer** from this website https://developer.nvidia.com/cuda-downloads. This toolkit will install you both NVIDIA driver and CUDA. For example,

```
cd /usr/local/src
wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
sudo sh cuda_10.1.243_418.87.00_linux.run
```

However, you can install Nvidia driver separately by downloading an installer file from this website https://www.nvidia.com/Download/index.aspx.

For example:

```
cd /usr/local/src
sudo wget http://us.download.nvidia.com/tesla/418.87/NVIDIA-Linux-x86_64-418.87.01.run
sudo sh NVIDIA-Linux-x86_64-418.87.01.run
```

7. Execute the installer using **sh** command

```
sudo sh cuda_10.1.243_418.87.00_linux.run
```

8. It will take you to the main menu of installation. Type **accept** to EULA agreement and select **install**. It can take 4-5 minutes.

9. When it is done, both NVIDIA driver and CUDA toolkits can be found at **/usr/local/cuda/**.

10. Check if NVIDIA driver meets the graphical card or not

```
nvidia-smi
```

---

# Ubuntu

For Ubuntu, NVIDIA driver can be easily installed using **apt** or **apt-get** package manager.

1. Update the system and install the drivers, for example, using commands:
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install --no-install-recommends nvidia-384 libcuda1-384 nvidia-opencl-icd-384
sudo reboot
```

Note that the latest version of NVIDIA library on the day of this writing is 384. You can find the latest version before install using command:
```
sudo apt search nvidia
```

2. Then see if NVIDIA driver found GPU or not by running command:
```
nvidia-smi
```

## Contact 

Rangsiman Ketkaew - rangsiman1993@gmail.com

