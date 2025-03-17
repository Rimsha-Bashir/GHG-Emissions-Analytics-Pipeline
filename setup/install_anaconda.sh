#!/bin/bash

cd "$HOME/bin"

# Download Anaconda using wget
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-0-Linux-x86_64.sh

# Install Anaconda, specify installation location to $HOME/bin/anaconda3
bash Anaconda3-2023.03-0-Linux-x86_64.sh -b -p "$HOME/bin/anaconda3"

# Clean up the installer
rm -f Anaconda3-2023.03-0-Linux-x86_64.sh

# Add Anaconda to PATH
echo 'export PATH="$HOME/bin/anaconda3/bin:$PATH"' >> "$HOME/.bashrc"

# Reload .bashrc to update the PATH
source "$HOME/.bashrc"

echo "Anaconda has been installed in $HOME/bin/anaconda3"
