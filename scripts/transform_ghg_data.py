import pyspark
import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder \
    .appName('ghg-test') \
    .getOrCreate()

input_path = "gs://ghg-bucket/ghg_data_*.csv"
df = spark.read.csv(input_path, header=True)
