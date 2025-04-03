#!/bin/bash


source .env

check_response() {
    http_code=$1

    if [[ "$http_code" -eq 200 ]]; then
        echo -e "Success"
    else
        echo -e "Error: HTTP Status Code: $http_code"
        exit 1
    fi
}


flow_exists=$(curl -s -o /dev/null -w "%{http_code}" -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows/${NAMESPACE}/gcp_upload" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}")

http_code=$flow_exists

if [[ "$http_code" -eq 200 ]]; then
    # Flow already exists
    echo -e "\nGCP Upload flow already exists..."
else
    # Flow doesn't exist, create it silently
    echo -e "\nCreating the flow as it does not exist..."
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
        -H "Content-Type: application/x-yaml" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
        --data-binary @gcp_upload.yml)

    http_code=$response
    # Check if the flow creation was successful
    if [[ "$http_code" -eq 200 ]]; then
        echo -e "\nGCP Upload flow created successfully."
    else
        echo -e "\nError creating the GCP Upload flow."
        exit 1
    fi
fi

execution_id=$(curl -s -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_upload" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" | jq -r '.id')

if [[ -z "$execution_id" || "$execution_id" == "null" ]]; then
    echo -e "\n!!!------Error triggering GCP Upload flow execution"
    exit 1
fi

echo -e "\nGCP Upload flow execution triggered successfully. Execution ID: $execution_id"

# Check execution status
execution_status="RUNNING"
while [[ "$execution_status" == "RUNNING" || "$execution_status" == "QUEUED" ]]; do
    sleep 15 
    execution_status=$(curl -s -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/$execution_id" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" | jq -r '.state.current')
    echo -e "\nCurrent execution status: RUNNING"
done

if [[ "$execution_status" == "SUCCESS" ]]; then
    echo -e "\n----------------GCP Upload execution completed successfully---------------------"
else
    echo -e "\n!!!------GCP Upload execution failed with status: $execution_status"
    exit 1
fi

exit 0