#!/bin/bash

# Source environment variables from .env file
source .env

# Post the flow to Kestra
echo "Creating the flow in Kestra..."
curl -v POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
    -H "Content-Type: application/x-yaml" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
    --data-binary @gcp_kv.yml

# Check if the flow creation was successful
if [ $? -eq 0 ]; then
    echo "----------------Flow created successfully---------------------"
else
    echo "!!!------Error creating the flow."
    exit 1
fi

# Set a Key-Value pair (for example, GCP_CREDS) in Kestra
# The JSON file for the key-value pair should be passed as a parameter
GCP_CREDS_FILE="~/.gc/ghg-creds.json"

echo "Setting Key-Value pair in Kestra..."

curl -v PUT "http://$VM_IP:$KESTRA_PORT/api/v1/namespaces/$NAMESPACE/kv/GCP_CREDS" \
     -H "Content-Type: application/json" \
     -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
     --data-binary @"$GCP_CREDS_FILE"


# Check if the KV pair was set successfully
if [ $? -eq 0 ]; then
    echo "----------------Key-Value pair set successfully----------------"
else
    echo "!!!------Error setting Key-Value pair."
    exit 1
fi
