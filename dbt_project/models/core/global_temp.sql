-- Global Temperature Change Over Time

{{
    config(
        materialized='table'
    )
}}
-- 
SELECT 
    year,
    SUM(total_co2) AS global_co2_emissions,
    SUM(total_ghg) AS global_ghg_emissions,

    AVG(temperature_change_from_co2) AS co2_temp_change,
    MIN(temperature_change_from_co2) as min_co2_temp_change, 
    MAX(temperature_change_from_co2) as max_co2_temp_change,
    
    AVG(temperature_change_from_ch4) AS methane_temp_change,
    MAX(temperature_change_from_ch4) AS max_methane_temp_change,
    MIN(temperature_change_from_ch4) AS min_methane_temp_change,

    SUM(temperature_change_from_n2o) AS n2o_temp_change,
    MIN(temperature_change_from_n2o) AS min_n2o_temp_change,
    MAX(temperature_change_from_n2o) AS max_n2o_temp_change

FROM {{ ref('fact_emissions') }}
GROUP BY year