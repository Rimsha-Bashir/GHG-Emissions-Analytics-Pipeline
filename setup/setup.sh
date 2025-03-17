#!/bin/bash

source .env
CURR_DIR="$(dirname "$0")"

# Update and install required packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget unzip git

echo "Creating bin/ dir to install dependencies..."
INSTALL_DIR="$HOME/bin" # dir where all applications will be installed
mkdir -p "$INSTALL_DIR"

# Make sure install scripts are executable
chmod +x "${CURR_DIR}"/install_*.sh

# Installing Anaconda
echo "Installing Anaconda..."
bash "${CURR_DIR}/install_anaconda.sh"


# Installing Docker and Docker Compose
echo "Installing Docker..."
bash "${CURR_DIR}/install_docker.sh"

Installing Terraform 
echo "Installing Terraform..."
bash "${CURR_DIR}/install_terraform.sh"


# Installing Spark 
echo "Installing Spark..."
bash "${CURR_DIR}/install_spark.sh"

# Set service account credentials
echo "Setting service account credentials..."
bash "${CURR_DIR}/set_credentials.sh"


echo "Setup completed successfully! 🎉"