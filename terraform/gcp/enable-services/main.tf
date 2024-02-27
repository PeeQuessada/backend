terraform {
  required_version = ">= 0.13"
  required_providers {
    google = ">= 5.17.0"
    local  = ">= 2.4.1"
  }
  backend "gcs" { # cloud storage
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_project_service" "enable_artifact_registry_api" {
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_cloud_resource_manager_api" {
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_container_api" {
  service                    = "container.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_sqladmin_api" {
  service                    = "sqladmin.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_servicecontrol_api" {
  service                    = "servicecontrol.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_apigateway_api" {
  service                    = "apigateway.googleapis.com"
  disable_dependent_services = true
}