# Global Greenhouse Gas (GHG) & CO₂ Emissions Data Pipeline 🌍 

## Table of Contents

- [Overview](#overview)
- [Problem Statement](#problem-statement-the-climate-challenge)
    - [Key Research Questions](#key-research-questions)
- [Objectives](#objectives)
- [Data Source](#data-source)
    - [Citation](#citation)
- [Tech Stack](#tech-stack)
- [Data Pipeline Architecture Diagram](#pipeline-architecture)
- [DBT Lineage Graph](#dbt-lineage-view)
- [Dashboard](#dashboard)
- [Instructions to Reproduce](#instructions-to-reproduce)


## Overview

Climate change is one of the most pressing global challenges, with greenhouse gas (GHG) emissions—especially carbon dioxide (CO₂)—being a major driver of rising global temperatures. Understanding emission trends is critical for policymakers, researchers, and sustainability leaders aiming to mitigate climate change and develop effective carbon reduction strategies.

![CO2+GHG](./images/GHGCO22.jpg)

## Problem Statement: The Climate Challenge

Greenhouse gases (GHGs), especially carbon dioxide (CO₂), are major contributors to climate change. Human activities like fossil fuel combustion, deforestation, and agriculture have significantly increased CO₂ emissions, driving global warming and its associated impacts. These include:

- **Rising Global Temperatures**: A 1.1°C increase since pre-industrial times, with potential catastrophic effects.
- **Extreme Weather Events**: Intensified hurricanes, floods, and droughts affecting vulnerable regions.
- **Health Risks**: Air pollution causing respiratory and cardiovascular diseases.
- **Economic & Social Disruptions**: Costing billions globally, with developing nations most affected.

### Key Research Questions

- How have global CO₂ emissions changed over time?
- Which countries and regions contribute the most to emissions?
- What sectors and sources drive emissions the most?
- How do per-capita emissions compare across countries?

## Objectives

This project aims to automate the ingestion, processing, and analysis of CO₂ & GHG emissions data to provide actionable insights for climate action, by examining trends in global CO₂ emissions over time to understand the scale and direction of the issue and identifying some key contributors to CO₂ emissions, such as countries and industries, and assess their roles in climate change.

- Automate data ingestion of global emissions dataset using Kestra.
- Process large-scale datasets efficiently with PySpark.
- Store structured data in Google Cloud Storage (GCS) and BigQuery for analytics.
- Transform raw data into insightful models using DBT.
- Enable interactive visualizations with Power BI / Metabase.

## Data Source

This project uses the  CO2 and Greenhouse Gas Emissions dataset provided by [Our World in Data](https://github.com/owid/co2-data). You can find out more about the dataset and related metadata from the [codebook](https://github.com/owid/co2-data/blob/master/owid-co2-codebook.csv) provided. It includes a description and source for each indicator in the dataset.

Special thanks to them for making this valuable data publicly available. You can explore more such dataset on their [website](https://ourworldindata.org/). 

#### Citation
Hannah Ritchie, Pablo Rosado and Max Roser (2023) - “CO₂ and Greenhouse Gas Emissions” Published online at OurWorldinData.org. Retrieved from: ['https://ourworldindata.org/co2-and-greenhouse-gas-emissions'](https://ourworldindata.org/co2-and-greenhouse-gas-emissions) [Online Resource]

## Tech Stack 

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) 
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white) <img src="https://img.shields.io/badge/Apache%20Spark-FDEE21?style=for-the-badge&logo=apachespark&logoColor=black" width="140" alt="Apache Spark">
![Kestra](https://img.shields.io/badge/Kestra-390380?style=for-the-badge&logo=kestra&logoColor=ffffff)
![BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=for-the-badge&logo=googlebigquery&logoColor=white)
![DBT](https://img.shields.io/badge/DBT-FF6F00?style=for-the-badge&logo=dbt&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Anaconda](https://img.shields.io/badge/Anaconda-%2344A833.svg?style=for-the-badge&logo=anaconda&logoColor=white)
![Jupyter Notebook](https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-the-badge&logo=jupyter&logoColor=white)
![Power BI](https://img.shields.io/badge/power_bi-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)


## Pipeline Architecture Diagram

![Arch Diagram](images/ghg_arch.drawio.svg)

## DBT Lineage View 

This Lineage Graph represents the DAG, showing the flow of data between dbt models.. 

![dbtmodels](./images/LineageGraph.PNG)

## Dashboard 

A high-level snapshot of total greenhouse gas (GHG) emissions, CO₂ emissions, and their impact on global temperature trends over time.

![Page-1](./images/dashboard-pg1.PNG)

A geographic breakdown of emissions, showing region-wise contributions, emission per capita, and regional growth trends over the years.

![Page-2](./images/dashboard-pg2.PNG)

A source-wise breakdown of major contributors to CO2 emissions and an examination of emissions in relation to economic growth.

![Page-3](./images/dashboard-pg3.PNG)

An analysis of temperature change due to Greenhouse gas emissions since pre-industrial times. 

![Page-4](./images/dashboard-pg4.PNG)


You can view a preview of this dashboard in my novypro account, [here](https://project.novypro.com/oRqeXa).

## Instructions to Reproduce

Steps to reproduce this end to end pipeline has been documented in [setup.md](./setup/setup.md). 

