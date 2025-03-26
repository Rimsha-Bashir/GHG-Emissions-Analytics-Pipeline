#!/bin/bash

# Source environment variables from .env file
source .env

# Post the flow to Kestra
echo -e "\n\nCreating the gcp_upload.yml flow in Kestra..."
curl -v POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
    -H "Content-Type: application/x-yaml" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
    --data-binary @gcp_upload.yml

# Check if the flow creation was successful
if [ $? -eq 0 ]; then
    echo -e "\n----------------gcp_upload.yml created successfully---------------------"
else
    echo -e "\n!!!------Error creating the flow gcp_upload.yml."
    exit 1
fi



echo -e "\n\nExecuting the flow gcp_upload.yml in Kestra..."
curl -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_upload" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}"

# Check if the flow execution was successful
if [ $? -eq 0 ]; then
    echo -e "\n----------------gcp_upload.yml executed successfully----------------"
else
    echo -e "\n!!!------Error executing the flow gcp_upload.yml"
    exit 1
fi