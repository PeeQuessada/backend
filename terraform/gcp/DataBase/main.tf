# First steps
# Enable K8s https://console.cloud.google.com/apis/api/container.googleapis.com/overview
# Enable GAR https://console.cloud.google.com/apis/api/artifactregistry.googleapis.com/
# https://console.cloud.google.com/apis/api/cloudresourcemanager.googleapis.com
# Create IAM User and download creadentials in the current folder
# export GOOGLE_APPLICATION_CREDENTIALS="./credentials.json"

terraform {
  required_version = ">= 0.13"
  required_providers {
    google = ">= 5.17.0"
    local  = ">= 2.4.1"
  }
  backend "gcs" { # cloud storage
    # bucket = "us-central1-my-project-buckey-3"
    # prefix = "terraform/state/infra"
  }
}

# # Cria um serviço API Gateway
# resource "google_api_gateway_api" "default" {
#   name = var.api_name

#   # Configura o serviço para rotear para o Cloud SQL
#   gateway {
#     service_url = google_sql_database_instance.default.connection_name
#   }
# }

# # Cria um balanceador de carga para o serviço API Gateway
# resource "google_compute_global_forwarding_rule" "default" {
#   name = var.forwarding_rule_name

#   target = google_api_gateway_api.default.self_link

#   # Configura o balanceador de carga para HTTPS
#   port_range = "8080"
#   target_port = 8080 
# }

# resource "google_compute_firewall" "kubernetes" {
#   name = var.firewall_name

# gcloud config set compute/region <region> 
# gcloud config set compute/zone <zone>