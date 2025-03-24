#!/bin/bash

CURR_DIR="$(dirname "$0")"
chmod +x "${CURR_DIR}"/execute_*.sh

echo "Executing gcp_key flow in Kestra..."
if bash "${CURR_DIR}/execute_gcp_kv.sh"; then
  echo "-------------------gcp_key flow executed successfully! ✅ "
else
  echo "---------!!! Error: gcp_key flow execution failed!" >&2
  exit 1
fi

echo "Executing gcp_upload flow in Kestra..."
if bash "${CURR_DIR}/execute_gcp_upload.sh"; then
  echo "-------------------gcp_upload flow executed successfully! ✅ "
else
  echo "---------!!!Error: gcp_upload flow execution failed!" >&2
  exit 1
fi

echo "*****All flows executed successfully!*****"
