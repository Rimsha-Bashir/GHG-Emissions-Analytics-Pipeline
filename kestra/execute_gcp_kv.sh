#!/bin/bash

# Source environment variables from .env file
source .env

# Function to check curl response based on status code
check_response() {
    http_code=$1

    if [[ "$http_code" -eq 200 ]]; then
        echo "Success"
    else
        echo "Error: HTTP Status Code: $http_code"
        exit 1
    fi
}

# Check if the flow already exists (suppress body)
flow_exists=$(curl -s -o /dev/null -w "%{http_code}" -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows/${NAMESPACE}/gcp_kv" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}")

# Extract HTTP status code
http_code=$flow_exists

if [[ "$http_code" -eq 200 ]]; then
    echo "GCP KV flow already exists..."
else
    echo "Creating the flow as it does not exist..."
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
        -H "Content-Type: application/x-yaml" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
        --data-binary @gcp_kv.yml)

    http_code=$response
    if [[ "$http_code" -eq 200 ]]; then
        echo "GCP KV flow created successfully."
    else
        echo "Error creating the GCP KV flow. HTTP Status Code: $http_code"
        exit 1
    fi
fi

# Execute the flow gcp_kv.yml in Kestra and capture execution ID
execution_response=$(curl -s -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_kv" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}")

execution_id=$(echo "$execution_response" | jq -r '.id')

if [[ -z "$execution_id" || "$execution_id" == "null" ]]; then
    echo "Error triggering GCP KV flow execution!"
    exit 1
else
    echo "GCP KV flow execution triggered successfully. Execution ID: $execution_id"
fi

# Wait and check execution status
echo "Checking execution status..."
sleep 5  

while true; do
    execution_status=$(curl -s -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${execution_id}" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" | jq -r '.state.current')

    echo "Current execution status: $execution_status"

    if [[ "$execution_status" == "SUCCESS" || "$execution_status" == "WARNING" ]]; then
        echo "GCP KV flow execution completed successfully!"
        break
    elif [[ "$execution_status" == "FAILED" || "$execution_status" == "TERMINATED" ]]; then
        echo "Error: GCP KV flow execution failed!"
        exit 1
    fi

    sleep 5  # Check every 5 seconds
done

# Set a GCP_CREDS in Kestra
GCP_CREDS_FILE="$HOME/.gc/ghg-creds.json"

response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT "http://$VM_IP:$KESTRA_PORT/api/v1/namespaces/$NAMESPACE/kv/GCP_CREDS" \
     -H "Content-Type: application/json" \
     -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
     --data-binary @"$GCP_CREDS_FILE")

http_code=$response

echo "GCP_CREDS Key Value pair set status: $(check_response "$http_code")"

exit 0 
