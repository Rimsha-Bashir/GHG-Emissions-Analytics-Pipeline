#!/bin/bash

# Source environment variables from .env file
source .env

echo -e "\n\ncd to Scripts folder..."
cd ..
cd scripts

echo -e "\n\ncopy transform_ghg_data.py to GCP bucket..."
gsutil cp transform_ghg_data.py gs://ghg-bucket/scripts/

echo -e "\n\ncd to kestra folder..."
cd .. 
cd kestra

echo -e "\n\nCreating the gcp_spark_bq.yml flow in Kestra..."
curl -v POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/flows" \
    -H "Content-Type: application/x-yaml" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}" \
    --data-binary @gcp_spark_bq.yml

# Check if the flow creation was successful
if [ $? -eq 0 ]; then
    echo -e "\n----------------gcp_spark_bq.yml created successfully---------------------"
else
    echo -e "\n!!!------Error creating the flow gcp_spark_bq.yml"
    exit 1
fi

echo -e "\n\nExecuting the flow gcp_spark_bq.yml in Kestra..."
curl -X POST "http://${VM_IP}:${KESTRA_PORT}/api/v1/executions/${NAMESPACE}/gcp_spark_bq" \
    -u "${KESTRA_EMAIL}:${KESTRA_PASSWORD}"

# Check if the flow execution was successful
if [ $? -eq 0 ]; then
    echo -e "\n----------------gcp_spark_bq.yml executed successfully----------------"
else
    echo -e "\n!!!------Error executing the flow gcp_spark_bq.yml"
    exit 1
fi


