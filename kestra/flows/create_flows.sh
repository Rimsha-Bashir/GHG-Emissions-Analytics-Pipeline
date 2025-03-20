#!/bin/bash

cd ../.. && source .env
curl -v -X POST "http://34.78.176.130:8080/api/v1/flows" -H "Content-Type: application/x-yaml" -u "bashirrimsha22@gmail.com:kestra" --data-binary @created-by-api.yml