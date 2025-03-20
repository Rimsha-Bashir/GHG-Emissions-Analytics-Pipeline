#!/bin/bash

# KEY_PATH - full path of the SERVICE ACCOUNT CREDENTIAL file. 
# To ensure that credentials are set up automatically every time you start a new shell session on your VM.

set -a  

# Adjust the path to match your repo location
ENV_FILE="$HOME/GHG-Emissions-Analytics-Pipeline/.env"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

set +a

# Add the environment variable GOOGLE_APPLICATION_CREDENTIALS to the .bashrc file
echo "export GOOGLE_APPLICATION_CREDENTIALS=${KEY_PATH}" >> ~/.bashrc

# Add the activation command to the .bashrc file
echo "gcloud auth activate-service-account --key-file=${KEY_PATH}" >> ~/.bashrc

# Source the updated .bashrc file for the current terminal session
source ~/.bashrc

echo "Service account is activated and authenticated"
