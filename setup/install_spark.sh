#!/bin/bash

cd "$HOME/bin"

# JAVA
echo "Downloading JAVA..."
wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
tar xzfv openjdk-11.0.2_linux-x64_bin.tar.gz
rm openjdk-11.0.2_linux-x64_bin.tar.gz 

echo "Exporting JAVA_HOME and Adding JAVA to PATH..."
echo 'export JAVA_HOME="${HOME}/bin/jdk-11.0.2"' >> ~/.bashrc 
echo 'export PATH="${JAVA_HOME}/bin:${PATH}"' >> ~/.bashrc




# SPARK
echo "Dowloading SPARK..."
wget https://archive.apache.org/dist/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz
tar xzfv spark-3.3.2-bin-hadoop3.tgz
rm spark-3.3.2-bin-hadoop3.tgz

echo "Exporting SPARK_HOME and Adding SPARK to PATH..."
# PYSPARK
echo 'export SPARK_HOME="${HOME}/bin/spark-3.3.2-bin-hadoop3"' >> ~/.bashrc
echo 'export PATH="${SPARK_HOME}/bin:${PATH}"' >> ~/.bashrc



# PYTHONPATH
echo "Exporting PYTHONPATH..."
echo 'export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"' >> ~/.bashrc
echo 'export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9.5-src.zip:$PYTHONPATH"' >> ~/.bashrc



# Reload to Update PATH
source "$HOME/.bashrc"



echo "Successfully Installed SPARK! ✅"