#!/bin/bash

CURR_DIR="$(dirname "$0")"
chmod +x "${CURR_DIR}"/execute_*.sh

echo "\nGCP KEYS SETUP IN KESTRA..."
if bash "${CURR_DIR}/execute_gcp_kv.sh"; then
  echo "\n-------------------gcp_key flow executed successfully! ✅ "
else
  echo "\n---------!!! Error: gcp_key flow execution failed!" >&2
  exit 1
fi

echo "\nDATA INGESTION INTO GCS BUCKET AND BIGQUERY..."
if bash "${CURR_DIR}/execute_gcp_upload.sh"; then
  echo "\n-------------------gcp_upload flow executed successfully! ✅ "
else
  echo "\n---------!!!Error: gcp_upload flow execution failed!" >&2
  exit 1
fi

echo "\n*****All flows executed successfully!*****"
