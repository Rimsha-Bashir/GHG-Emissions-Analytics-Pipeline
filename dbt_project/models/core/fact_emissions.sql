{{
    config(
        materialized='table',
        partition_by={
        'field': 'year', 
        'data_type': 'int64',
        'range': {
                'start': 1750,  
                'end': 2100,  
                'interval': 10 
            }},
        cluster_by=['country']
    )
}}
with fact_table as (
    SELECT *
    FROM {{ ref('stg_emissions') }}
)

SELECT * from fact_table