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

# # Importa o provedor Google Cloud
# provider "google" {
#   project = var.project_id
#   region  = var.region
# }

# # Cria um cluster Kubernetes Engine
# resource "google_kubernetes_engine_cluster" "default" {
#   name = var.cluster_name
#   node_count = var.node_count

#   # Configura o Cloud SQL como provedor de banco de dados
#   database_provider {
#     service = "CLOUD_SQL"
#   }
# }

# # Cria um Cloud SQL
# resource "google_sql_database_instance" "default" {
#   name = var.database_name
#   database_version = "POSTGRES_14"
#   machine_type = "e2-micro"
#   region = var.region

#   # Configura o acesso ao banco de dados do cluster Kubernetes
#   settings {
#     ip_configuration {
#       authorized_networks = [google_kubernetes_engine_cluster.default.network]
#     }
#   }
# }

# # Cria um serviço API Gateway
# resource "google_api_gateway_api" "default" {
#   name = var.api_name

#   # Configura o serviço para rotear para o Cloud SQL
#   gateway {
#     service_url = google_sql_database_instance.default.connection_name
#   }
# }

# # Cria um deployment Kubernetes para a aplicação
# resource "google_kubernetes_engine_deployment" "default" {
#   name = var.deployment_name
#   replicas = 1

#   # Configura o container da aplicação
#   template {
#     metadata {
#       labels = {
#         app = var.app_name
#       }
#     }

#     spec {
#       containers {
#         name = var.container_name
#         image = var.container_image

#         # Configura o acesso ao banco de dados através da API Gateway
#         env {
#           name = "DATABASE_URL"
#           value = "https://${google_api_gateway_api.default.name}.gateway.region.${google_region.default.name}.gcp.net/"
#         }
#       }
#     }
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

#   network = google_kubernetes_engine_cluster.default.network

#   allow {
#     protocol = "tcp"
#     ports = ["80", "443", "8080"]
#   }

#   allow {
#     protocol = "ssh"
#   }

#   source_ranges = ["0.0.0.0/0"]
# }

# gcloud config set compute/region <region> 
# gcloud config set compute/zone <zone>

