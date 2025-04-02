import pyspark
import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql import types
from pyspark.sql import SparkSession


spark = SparkSession.builder \
    .appName('test') \
    .getOrCreate()

input_path = f"gs://ghg-bucket/raw/emissions_data.csv"
output_path = f"gs://ghg-bucket/processed/emissions_data"

schema = types.StructType([ 
    types.StructField('country', types.StringType(), True),
    types.StructField('year', types.IntegerType(), True),
    types.StructField('iso_code', types.StringType(), True),
    types.StructField('population', types.LongType(), True),
    types.StructField('gdp', types.DecimalType(20, 0), True),
    types.StructField('cement_co2', types.FloatType(), True),
    types.StructField('cement_co2_per_capita', types.FloatType(), True),
    types.StructField('co2', types.FloatType(), True),
    types.StructField('co2_growth_abs', types.FloatType(), True),
    types.StructField('co2_growth_prct', types.FloatType(), True),
    types.StructField('co2_including_luc', types.FloatType(), True),
    types.StructField('co2_including_luc_growth_abs', types.FloatType(), True),
    types.StructField('co2_including_luc_growth_prct', types.FloatType(), True),
    types.StructField('co2_including_luc_per_capita', types.FloatType(), True),
    types.StructField('co2_including_luc_per_gdp', types.FloatType(), True),
    types.StructField('co2_including_luc_per_unit_energy', types.FloatType(), True),
    types.StructField('co2_per_capita', types.FloatType(), True),
    types.StructField('co2_per_gdp', types.FloatType(), True),
    types.StructField('co2_per_unit_energy', types.FloatType(), True),
    types.StructField('coal_co2', types.FloatType(), True),
    types.StructField('coal_co2_per_capita', types.FloatType(), True),
    types.StructField('consumption_co2', types.FloatType(), True),
    types.StructField('consumption_co2_per_capita', types.FloatType(), True),
    types.StructField('consumption_co2_per_gdp', types.FloatType(), True),
    types.StructField('cumulative_cement_co2', types.FloatType(), True),
    types.StructField('cumulative_co2', types.FloatType(), True),
    types.StructField('cumulative_co2_including_luc', types.FloatType(), True),
    types.StructField('cumulative_coal_co2', types.FloatType(), True),
    types.StructField('cumulative_flaring_co2', types.FloatType(), True),
    types.StructField('cumulative_gas_co2', types.FloatType(), True),
    types.StructField('cumulative_luc_co2', types.FloatType(), True),
    types.StructField('cumulative_oil_co2', types.FloatType(), True),
    types.StructField('cumulative_other_co2', types.FloatType(), True),
    types.StructField('energy_per_capita', types.FloatType(), True),
    types.StructField('energy_per_gdp', types.FloatType(), True),
    types.StructField('flaring_co2', types.FloatType(), True),
    types.StructField('flaring_co2_per_capita', types.FloatType(), True),
    types.StructField('gas_co2', types.FloatType(), True),
    types.StructField('gas_co2_per_capita', types.FloatType(), True),
    types.StructField('ghg_excluding_lucf_per_capita', types.FloatType(), True),
    types.StructField('ghg_per_capita', types.FloatType(), True),
    types.StructField('land_use_change_co2', types.FloatType(), True),
    types.StructField('land_use_change_co2_per_capita', types.FloatType(), True),
    types.StructField('methane', types.FloatType(), True),
    types.StructField('methane_per_capita', types.FloatType(), True),
    types.StructField('nitrous_oxide', types.FloatType(), True),
    types.StructField('nitrous_oxide_per_capita', types.FloatType(), True),
    types.StructField('oil_co2', types.FloatType(), True),
    types.StructField('oil_co2_per_capita', types.FloatType(), True),
    types.StructField('other_co2_per_capita', types.FloatType(), True),
    types.StructField('other_industry_co2', types.FloatType(), True),
    types.StructField('primary_energy_consumption', types.FloatType(), True),
    types.StructField('share_global_cement_co2', types.FloatType(), True),
    types.StructField('share_global_co2', types.FloatType(), True),
    types.StructField('share_global_co2_including_luc', types.FloatType(), True),
    types.StructField('share_global_coal_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_cement_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_co2_including_luc', types.FloatType(), True),
    types.StructField('share_global_cumulative_coal_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_flaring_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_gas_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_luc_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_oil_co2', types.FloatType(), True),
    types.StructField('share_global_cumulative_other_co2', types.FloatType(), True),
    types.StructField('share_global_flaring_co2', types.FloatType(), True),
    types.StructField('share_global_gas_co2', types.FloatType(), True),
    types.StructField('share_global_luc_co2', types.FloatType(), True),
    types.StructField('share_global_oil_co2', types.FloatType(), True),
    types.StructField('share_global_other_co2', types.FloatType(), True),
    types.StructField('share_of_temperature_change_from_ghg', types.FloatType(), True),
    types.StructField('temperature_change_from_ch4', types.FloatType(), True),
    types.StructField('temperature_change_from_co2', types.FloatType(), True),
    types.StructField('temperature_change_from_ghg', types.FloatType(), True),
    types.StructField('temperature_change_from_n2o', types.FloatType(), True),
    types.StructField('total_ghg', types.FloatType(), True),
    types.StructField('total_ghg_excluding_lucf', types.FloatType(), True),
    types.StructField('trade_co2', types.FloatType(), True),
    types.StructField('trade_co2_share', types.FloatType(), True)
])



df = spark.read \
    .option("header", "true") \
    .schema(schema) \
    .csv(input_path)

df = df.withColumn("gdp", F.col("gdp").cast(types.DecimalType(20, 0)))  # Ensure large number support

df = df.dropna(how="all")
df.coalesce(1).write.parquet(output_path, mode='overwrite')



