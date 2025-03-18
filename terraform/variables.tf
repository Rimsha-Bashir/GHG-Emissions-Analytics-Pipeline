variable "project" {
  description = "GHG GCP Project name"
  default     = "coral-velocity-451115-d9"
}

variable "location" {
  description = "GHG GCP provider location"
  default     = "EU"
}
variable "region" {
  description = "GHG GCP provider region"
  default     = "europe-west1"

}
variable "bq_dataset_staging" {
  description = "GHG GCP BigQuery Dataset"
  default     = "Staging"
}
variable "bq_dataset_analytics" {
  description = "GHG GCP BigQuery Dataset"
  default     = "Analytics"

}
variable "gcs_storage_class" {
  description = "GHG GCP Bucket Storage class"
  default     = "STANDARD"
}
variable "gcs_bucketname" {
  description = "GHG GCP Bucket name"
  default     = "ghg-bucket"
}
variable "spark_cluster_name" {
  description = "GHG GCP Spark Cluster Name"
  default     = "ghg-dataproc"
}