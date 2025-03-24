#!/bin/bash

# Source environment variables from .env file
source .env

# Post the flow to Kestra
echo "Creating the gcp_kv.yml flow in Kestra..."
curl -v POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
    -H "Content-Type: application/x-yaml" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
    --data-binary @gcp_upload.yml

# Check if the flow creation was successful
if [ $? -eq 0 ]; then
    echo "----------------gcp_upload.yml created successfully---------------------"
else
    echo "!!!------Error creating the flow gcp_upload.yml."
    exit 1
fi



echo "Executing the flow gcp_upload.yml in Kestra..."
curl -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_upload.yml" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}"

# Check if the flow execution was successful
if [ $? -eq 0 ]; then
    echo "----------------gcp_upload.yml executed successfully----------------"
else
    echo "!!!------Error executing the flow gcp_upload.yml"
    exit 1
fi