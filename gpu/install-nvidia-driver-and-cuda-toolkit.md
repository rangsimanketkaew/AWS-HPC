# Install NVIDIA driver and CUDA toolkit

## Prerequisite

1. root or sudo permission

## Red Hat or CentOS

*Please note that on the day of this writing I am using Red Hat version 8 and CentOS version 7 & 8*

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

However, you can install specific kernel-devel version on CentOS by using rpm package manager. 

- First, find and download rpm file of a specific version of library of interest from this website https://centos.pkgs.org, for example, [kernel-devel-3.10.0-1062.1.2.el7.x86_64](https://centos.pkgs.org/7/centos-updates-x86_64/kernel-devel-3.10.0-1062.1.2.el7.x86_64.rpm.html).

- Then use the following three commands for installing `kernel-devel` package:

   ```
   cd /usr/local/src
   sudo wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/kernel-devel-3.10.0-1062.1.2.el7.x86_64.rpm
   sudo rpm -i kernel-devel-3.10.0-1062.1.2.el7.x86_64.rpm
   ```

3. Disable **nouveau** by modifying GRUB, like this

```
sudo grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"
```

4. Reboot instance (and wait for 1 minute)

```
sudo reboot
```

5. Switch off X server

```
sudo systemctl isolate multi-user.target
```

6. Download a **CUDA toolkit installer** from this website https://developer.nvidia.com/cuda-downloads. This toolkit will install you both NVIDIA driver and CUDA.

```
cd /usr/local/src
sudo wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
```

Nevertheless, you are able to install the NVIDIA driver separately by downloading an installer file from this website https://www.nvidia.com/Download/index.aspx, like this

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

10. Finally, check if NVIDIA driver meets the graphical card

```
nvidia-smi
```

Example of output:

```
Tue Nov 19 02:26:13 2019
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 418.39       Driver Version: 418.39       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:04:00.0 Off |                  Off |
| N/A   37C    P0    40W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  Tesla V100-SXM2...  On   | 00000000:06:00.0 Off |                  Off |
| N/A   34C    P0    39W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   2  Tesla V100-SXM2...  On   | 00000000:07:00.0 Off |                  Off |
| N/A   33C    P0    39W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   3  Tesla V100-SXM2...  On   | 00000000:08:00.0 Off |                  Off |
| N/A   34C    P0    39W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

---

## Ubuntu

For Ubuntu, NVIDIA driver can be easily installed using **apt** or **apt-get** package manager.

1. Update the system and install the drivers, for example, using the following commands

```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install --no-install-recommends nvidia-384 libcuda1-384 nvidia-opencl-icd-384
sudo reboot
```

The latest version of NVIDIA library on the day of this writing is 384. You can find the latest version before install using command

```
sudo apt search nvidia
```

2. The CUDA can be found at, e.g., `/usr/local/cuda` and `/usr/local/cuda-10.1`.

3. Then see if NVIDIA driver found GPU or not by running command

```
nvidia-smi
```

Example of output:

```
Tue Nov 19 02:26:13 2019
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 418.39       Driver Version: 418.39       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:04:00.0 Off |                  Off |
| N/A   37C    P0    40W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  Tesla V100-SXM2...  On   | 00000000:06:00.0 Off |                  Off |
| N/A   34C    P0    39W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   2  Tesla V100-SXM2...  On   | 00000000:07:00.0 Off |                  Off |
| N/A   33C    P0    39W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   3  Tesla V100-SXM2...  On   | 00000000:08:00.0 Off |                  Off |
| N/A   34C    P0    39W / 300W |      0MiB / 16130MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

## Contact 

Rangsiman Ketkaew - rangsiman1993@gmail.com

