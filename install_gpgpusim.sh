#!/bin/bash
# ******************************************
#	Scripts for installing GPGPU-Sim on Linux
#	 by Gunjae Koo (gunjae.koo@gmail.com)
# ******************************************
# This script for automating the installation process of GPGPU-Sim v4.
# The installation process is tested on Linux Mint 19.3 64-bits (based on Ubuntu 18.04 LTS)

# functions
function confirm() {
	# call with a prompt string or use a default
	read -r -p "Will you install $1? [y/N] " response
	case $response in
		[yY][eE][sS]|[yY])
			true
			;;
		*)
			false
			;;
	esac
}

# -------------------------------------
# Installing C/C++ compilers
# -------------------------------------
echo " --------------------------------------------------------- "
echo " Ubuntu 18.04 LTS already includes gcc/g++ 7.5 version     "
echo " --------------------------------------------------------- "

# -------------------------------------------------
# Installing dependent libraries
# -------------------------------------------------
echo " -------------------------------------------------- "
echo " Installing required libraries"
echo " -------------------------------------------------- "
sudo apt-get install wget gnupg software-properties-common

# -------------------------------------------------
# Installing CUDA Toolkit and CUDA SDK
# -------------------------------------------------
# In this installation script we will use CUDA 10.1
echo " -------------------------------------------------- "
echo " Downloadiing CUDA installer"
echo " -------------------------------------------------- "
confirm "install_cuda_10.1" && \
	wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb && \
	sudo dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb && \
	sudo apt-key add /var/cuda-repo-10-1-local-10.1.105-418.39/7fa2af80.pub && \
	sudo apt-get update && \
	sudo apt-get install cuda

# -------------------------------------------------
# Install GPGPU-Sim
# -------------------------------------------------
echo " -------------------------------------------------- "
echo " Installing apps for GPGPU-Sim"
echo " -------------------------------------------------- "
sudo apt-get install build-essential xutils-dev bison zlib1g-dev flex libglu1-mesa-dev
echo " -------------------------------------------------- "
echo " Installing apps for doxygen"
echo " -------------------------------------------------- "
sudo apt-get install doxygen graphviz
echo " -------------------------------------------------- "
echo " Installing apps for AerialVision"
echo " -------------------------------------------------- "
sudo apt-get install python-pmw python-ply python-numpy libpng-dev python-matplotlib
echo " -------------------------------------------------- "
echo " Installing CUDA library patch"
echo " -------------------------------------------------- "
sudo apt-get install libcuda1-346-updates

# ------------------------------------------------
# Before compiling GPGPU-Sim
# ------------------------------------------------
echo ""
echo " ==========================================================="
echo " Source setup_gpgpusim"
echo " ==========================================================="
echo ""
echo " Then, make!!!"
