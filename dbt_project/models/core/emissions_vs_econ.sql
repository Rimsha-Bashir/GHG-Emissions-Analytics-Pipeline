-- Emissions by the Economiic growth
{{
    config(
        materialized='table'
    )
}}

SELECT 
    country,
    year,
    gdp,
    co2_per_capita
FROM {{ ref('fact_emissions') }}