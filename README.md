# Global Greenhouse Gas (GHG) & CO₂ Emissions Data Pipeline 🌍 

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
Hannah Ritchie, Pablo Rosado and Max Roser (2023) - “CO₂ and Greenhouse Gas Emissions” Published online at OurWorldinData.org. Retrieved from: ['https://ourworldindata.org/co2-and-greenhouse-gas-emissions']('https://ourworldindata.org/co2-and-greenhouse-gas-emissions') [Online Resource]

## Tech Stack 

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
<img src="./images/Kestra.full.logo.dark.jpg" width="119"></img>

## Pipeline Architecture