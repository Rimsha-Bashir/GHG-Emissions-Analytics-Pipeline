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

echo -e "\n\nChanging directory to Scripts folder..."
cd ../scripts || { echo "Error: Scripts directory not found!"; exit 1; }

echo -e "\n\nCopying transform_ghg_data.py to GCP bucket..."
gsutil cp transform_ghg_data.py gs://ghg-bucket/scripts/

if [[ $? -eq 0 ]]; then
    echo -e "\n----------------transform_ghg_data.py copied successfully---------------------"
else
    echo -e "\n!!!------Error copying transform_ghg_data.py to GCP bucket"
    exit 1
fi

echo -e "\n\nChanging directory to Kestra folder..."
cd ../kestra || { echo "Error: Kestra directory not found!"; exit 1; }


flow_exists=$(curl -s -o /dev/null -w "%{http_code}" -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows/${NAMESPACE}/gcp_spark_bq" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}")

http_code=$flow_exists

if [[ "$http_code" -eq 200 ]]; then
    echo -e "\nGCP Spark BQ flow already exists... "
else
    # Flow doesn't exist, create it
    echo -e "\nCreating the gcp_spark_bq.yml flow as it does not exist..."
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
        -H "Content-Type: application/x-yaml" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
        --data-binary @gcp_spark_bq.yml)

    http_code=$response
    echo -e "\nGCP Spark BQ flow creation status: $(check_response "$http_code")"
fi

# Execute the flow gcp_spark_bq.yml in Kestra
execution_id=$(curl -s -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_spark_bq" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" | jq -r '.id')

if [[ -z "$execution_id" || "$execution_id" == "null" ]]; then
    echo -e "\n!!!------Error triggering GCP Spark BQ flow execution"
    exit 1
fi

echo -e "\nGCP Spark BQ flow execution triggered successfully. Execution ID: $execution_id"

# Check execution status
execution_status="RUNNING"
while [[ "$execution_status" == "RUNNING" || "$execution_status" == "QUEUED" ]]; do
    sleep 50  
    execution_status=$(curl -s -X GET "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/$execution_id" \
        -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" | jq -r '.state.current')
    echo -e "\nCurrent execution status: RUNNING"
done

if [[ "$execution_status" == "SUCCESS" || "$execution_status" == "WARNING" ]]; then
    echo -e "\n----------------Execution completed successfully---------------------"
else
    echo -e "\n!!!------Execution failed with status: $execution_status"
    exit 1
fi

exit 0