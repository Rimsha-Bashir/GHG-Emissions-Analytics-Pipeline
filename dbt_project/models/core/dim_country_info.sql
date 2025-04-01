{{
    config(
        materialized='table'
    )
}}


WITH latest_data AS (
    SELECT 
        country,
        iso_code,
        MAX(population) AS latest_population,
        MAX(gdp) AS latest_gdp
    FROM {{ ref('stg_emissions') }}
    GROUP BY country, iso_code
)
SELECT * FROM latest_data