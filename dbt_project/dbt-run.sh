#!/bin/bash

cd $HOME/GHG-Emissions-Analytics-Pipeline/dbt_project

echo -e "\nRunning dbt debug..."
dbt debug || { echo "Error: checks failed"; exit 1; }

echo -e "\nRunning dbt deps..."
dbt deps || { echo "Error: Failed to pull dependecies"; exit 1; }

echo -e "\nRunning dbt build in DEV..."
dbt build || { echo "Error: Build failed"; exit 1; }

echo -e "\nRunning dbt build in PROD..."
dbt build -t prod || { echo "Error: Build failed"; exit 1; }

echo -e "\nDBT models built successfully!"

exit 0




