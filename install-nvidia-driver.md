# Install NVIDIA driver


1. Identify if the GPU is running on your system
```sh
lspci -vnn | grep VGA
```

2. Install all development tools and dependencies
```
sudo yum update
sudo yum groupinstall "Development Tools"
sudo dnf install elfutils-libelf-devel "kernel-devel-uname-r == $(uname -r)"
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
cd $HOME
wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
sudo sh 
```

1. Execute the installer using **sh** command
```
sudo sh cuda_10.1.243_418.87.00_linux.run
```

8. It will take you to the main menu of installation. Type **accept** to EULA agreement and select **install**. It can take 4-5 minutes.

9. When it is done, both NVIDIA driver and CUDA toolkits can be found at **/usr/local/cuda/**.