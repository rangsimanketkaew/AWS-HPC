# Install OpenMPI

### Prerequisites
1. The tarball of OpenMPI.
2. tar - an archiving utility
3. root or sudo permission (optional)

1. Download the tarball of source of OpenMPi from its official website https://www.open-mpi.org. For example, on the day of this writing, I download OpenMPI version 4.0.2 and install it on Red Hat 8 and Ubuntu.
```
cd $HOME
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.2.tar.gz
```

2. Uncompress the tarball using tar.
```
tar -xvf openmpi-4.0.2.tar.gz
```

3. Configure settings and specify where you want to install OpenMPI.
```
cd openmpi
./configure --prefix=/usr/local/openmpi
```

Note that root or sudo permission is required for install OpenMPI on the global space. For the users, you should set prefix to directory under your home space.

4. Compile and 
```
sudo make all install
```

5. Add OpenMPI to the environment variables by specifying following commands in **.bashrc** or **.profile** file
```
vi $HOME/.bashrc
export PATH=/usr/local/openmpi/bin/:$PATH
export LD_LIBRARY_PATH=/usr/local/openmpi/lib/:$LD_LIBRARY_PATH
source $HOME/.bashrc
```

6. Check if OpenMPi is installed successfully
```
mpirun --version
```
