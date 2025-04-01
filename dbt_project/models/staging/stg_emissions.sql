{{
    config(
        materialized='view'
    )
}}


WITH source AS (
    SELECT 
        country,
        iso_code,
        year,
        population,
        gdp,

        -- Core CO₂ Emissions
        co2 AS total_co2,  -- CO₂ (Excluding LUC)
        co2_including_luc AS co2_total_incl_luc,  -- CO₂ (Including LUC)
        co2_per_capita,
        co2_per_gdp,

        -- Emission Growth
        co2_growth_abs AS co2_growth_absolute,
        co2_growth_prct AS co2_growth_percent,

         -- Total Greenhouse Gas (GHG) Emissions
        total_ghg,  -- Includes CO₂, CH₄, N₂O, etc.
        total_ghg_excluding_lucf,  -- GHG emissions excluding land use change & forestry (LULUCF)

        -- Cumulative CO₂ Emissions
        cumulative_co2,
        cumulative_co2_including_luc AS cumulative_co2_incl_luc,

        -- CO₂ by Fuel Type
        coal_co2,
        oil_co2,
        gas_co2,
        flaring_co2,
        cement_co2,
        trade_co2,
        other_industry_co2,

        -- Methane and NO2
        methane,
        methane_per_capita,
        nitrous_oxide,
        nitrous_oxide_per_capita,


        -- Land-Use Change CO₂
        land_use_change_co2,
        land_use_change_co2_per_capita,

        -- Global Share of CO2 Emissions
        share_global_co2,
        share_global_co2_including_luc AS share_global_co2_incl_luc,
        share_global_cumulative_co2,

        -- Temperature Change Contribution
        temperature_change_from_ch4,
        temperature_change_from_co2,
        temperature_change_from_ghg,
        temperature_change_from_n2o,
        share_of_temperature_change_from_ghg

    FROM {{ source('staging', 'emissions_data') }}
    WHERE country IS NOT NULL AND year IS NOT NULL
)

SELECT 
    *,
    SAFE_DIVIDE(total_co2, population) AS co2_per_capita_calc,
    SAFE_DIVIDE(total_ghg, population) AS ghg_per_capita_calc
FROM source
