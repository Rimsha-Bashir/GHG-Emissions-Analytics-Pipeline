{{
    config(
        materialized='table'
    )
}}

SELECT 
    country,
    year,
    total_co2,
    co2_per_capita
FROM {{ ref('fact_emissions') }}