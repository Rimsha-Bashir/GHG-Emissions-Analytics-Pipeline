#!/bin/bash

cd "$HOME/bin"

# Download Anaconda using wget
wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh

# Install Anaconda
bash Anaconda3-2024.10-1-Linux-x86_64.sh -b

# Clean up the installer
rm -f Anaconda3-2024.10-1-Linux-x86_64.sh

echo "Anaconda has been installed in $HOME/bin"