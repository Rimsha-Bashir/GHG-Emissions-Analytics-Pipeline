#!/bin/bash

# Ensure the bin directory exists (if not already created in previous scripts)
mkdir -p "$HOME/bin"

echo "Installing Docker and setting up..."
sudo apt-get install -y docker.io

# For Docker to start on booting the VM
echo "Docker to start on booting the VM..."
sudo systemctl enable docker

# Start Docker service
echo "Start Docker service...."
sudo systemctl restart docker

# Check if the 'docker' group exists to allow running Docker without sudo
if ! getent group docker >/dev/null; then
    echo "Creating the 'docker' group..."
    sudo groupadd docker
else
    echo "'docker' group already exists, skipping..."
fi

# Add the current user to the docker group
sudo gpasswd -a "$USER" docker

echo "Remember to logout later so your group membership is re-evaluated."

echo "Installing Docker Compose..."
# Download Docker Compose to $HOME/bin
wget https://github.com/docker/compose/releases/download/v2.32.4/docker-compose-linux-x86_64 -O "$HOME/bin/docker-compose"
chmod +x "$HOME/bin/docker-compose"

echo "Make docker-compose visible from any directory..."
grep -qxF 'export PATH="${HOME}/bin:${PATH}"' $HOME/.bashrc || echo 'export PATH="${HOME}/bin:${PATH}"' >> $HOME/.bashrc

# Reload .bashrc to make the new PATH active
echo "Reloading .bashrc..."
source $HOME/.bashrc

# Verify installations
echo "Running installation tests..."
docker run hello-world  # Check if Docker works
docker-compose --version  # Check if Docker Compose works

echo "Docker and Docker Compose installed successfully! ✅"
