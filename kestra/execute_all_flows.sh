#!/bin/bash

CURR_DIR="$(dirname "$0")"
chmod +x "${CURR_DIR}"/execute_*.sh

echo -e "\n\n\nGCP KEYS SETUP IN KESTRA..."
if bash "${CURR_DIR}/execute_gcp_kv.sh"; then
  echo -e "\n-------------------gcp_key flow executed successfully! "
else
  echo -e "\n---------!!! Error: gcp_key flow execution failed!" >&2
  exit 1
fi

echo -e "\n\n\nDATA INGESTION INTO GCS BUCKET..."
if bash "${CURR_DIR}/execute_gcp_upload.sh"; then
  echo -e "\n-------------------gcp_upload flow executed successfully!  "
else
  echo -e "\n---------!!!Error: gcp_upload flow execution failed!" >&2
  exit 1
fi

echo -e "\n\n\nSCRIPT UPLOAD, SPARK JOB SUBMIT AND BIGQUERY TABLES CREATION..."
if bash "${CURR_DIR}/execute_spark_bq.sh"; then
  echo -e "\n-------------------gcp_spark_bq flow executed successfully!  "
else
  echo -e "\n---------!!!Error: gcp_spark_bq flow execution failed!" >&2
  exit 1
fi


echo -e "\n\n\nAll flows executed successfully!✅"
exit 0 