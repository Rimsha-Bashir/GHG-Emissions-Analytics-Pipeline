#!/bin/bash

# Source environment variables from .env file
source .env

# Post the flow to Kestra
echo "Creating the gcp_kv.yml flow in Kestra..."
curl -v POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
    -H "Content-Type: application/x-yaml" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
    --data-binary @gcp_kv.yml

# Check if the flow creation was successful
if [ $? -eq 0 ]; then
    echo "----------------gcp_kv.yml created successfully---------------------"
else
    echo "!!!------Error creating the flow gcp_kv.yml."
    exit 1
fi



echo "Executing the flow gcp_kv.yml in Kestra..."
curl -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_kv" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}"

# Check if the flow execution was successful
if [ $? -eq 0 ]; then
    echo "----------------gcp_kv.yml executed successfully----------------"
else
    echo "!!!------Error executing the flow gcp_kv.yml"
    exit 1
fi



# Set a Key-Value pair (for example, GCP_CREDS) in Kestra
GCP_CREDS_FILE="$HOME/.gc/ghg-creds.json"  

echo "Setting GCP_CREDS KV Pair in Kestra..."

# Use PUT method to set the key-value pair
curl -v -X PUT "http://$VM_IP:$KESTRA_PORT/api/v1/namespaces/$NAMESPACE/kv/GCP_CREDS" \
     -H "Content-Type: application/json" \
     -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
     --data-binary @"$GCP_CREDS_FILE"  

# Check if the KV pair was set successfully
if [ $? -eq 0 ]; then
    echo "----------------GCP_CREDS set successfully----------------"
else
    echo "!!!------Error setting Key-Value pair GCP_CREDS."
    exit 1
fi
