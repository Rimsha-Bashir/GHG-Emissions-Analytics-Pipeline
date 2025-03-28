#!/bin/bash

# Source environment variables from .env file
source .env

# Function to check curl response based on status code
check_response() {
    http_code=$1

    if [[ "$http_code" -eq 200 ]]; then
        echo -e "Success"
    else
        echo -e "Error: HTTP Status Code: $http_code"
        exit 1
    fi
}

# Check if the flow already exists (suppress body)
flow_exists=$(curl -s -o /dev/null -w "%{http_code}" -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows/${NAMESPACE}/gcp_kv" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}")

# Extract HTTP status code
http_code=$flow_exists

if [[ "$http_code" -eq 200 ]]; then
    # Flow already exists
    echo -e "\nGCP KV flow already exists..."
else
    # Flow doesn't exist, create it silently
    echo -e "\nCreating the flow as it does not exist..."
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
        -H "Content-Type: application/x-yaml" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
        --data-binary @gcp_kv.yml)

    http_code=$response
    # Check if the flow creation was successful
    if [[ "$http_code" -eq 200 ]]; then
        echo -e "\nGCP KV flow created successfully."
    else
        echo -e "\nError creating the GCP KV flow. HTTP Status Code: $http_code"
        exit 1
    fi
fi

# Execute the flow gcp_kv.yml in Kestra (suppress body)
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_kv" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}")

http_code=$response

# Check if the flow execution was successful
echo "GCP KV flow execution status: $(check_response "$http_code")"

# Set a GCP_CREDS in Kestra
GCP_CREDS_FILE="$HOME/.gc/ghg-creds.json"

response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT "http://$VM_IP:$KESTRA_PORT/api/v1/namespaces/$NAMESPACE/kv/GCP_CREDS" \
     -H "Content-Type: application/json" \
     -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
     --data-binary @"$GCP_CREDS_FILE")

http_code=$response

echo "Key Value pairs set status: $(check_response "$http_code")"

exit 0 