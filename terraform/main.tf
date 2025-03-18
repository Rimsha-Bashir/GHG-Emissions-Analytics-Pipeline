terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.20.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region

}
resource "google_storage_bucket" "ghg_bucket" {
  name          = var.gcs_bucketname
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "staging" {
  dataset_id = var.bq_dataset_staging
}

resource "google_bigquery_dataset" "analytics" {
  dataset_id = var.bq_dataset_analytics
}

resource "google_dataproc_cluster" "dataproc-cluster" {
  name    = var.spark_cluster_name
  project = var.project
  region  = var.region

  cluster_config {

    master_config {
      num_instances = 1
      machine_type  = "n1-standard-4"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 500
      }
    }

    # Override or set some custom properties
    software_config {
      image_version = "2.0-debian10"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }


  }
}