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
  location      = var.location

}

resource "google_bigquery_dataset" "analytics" {
  dataset_id = var.bq_dataset_analytics
  location      = var.location

}

resource "google_dataproc_cluster" "dataproc-cluster" {
  name    = var.spark_cluster_name
  project = var.project
  region  = var.region
  
  cluster_config {

    gce_cluster_config {
      service_account = "ghg-user@${var.project}.iam.gserviceaccount.com"
      service_account_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
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