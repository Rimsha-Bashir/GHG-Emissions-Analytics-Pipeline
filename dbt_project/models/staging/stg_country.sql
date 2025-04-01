{{
    config(
        materialized='view'
    )
}}


WITH country_info AS (
    SELECT 
        country,
        iso_code,
        population, 
        gdp
    FROM {{ source('staging', 'emissions_data') }}
    WHERE country IS NOT NULL
)
SELECT 
    country,
    iso_code,
    MAX(population) AS latest_population,
    MAX(gdp) AS latest_gdp
FROM country_info
GROUP BY country, iso_code


