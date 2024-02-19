resource "kubernetes_deployment" "my-backend" {
  metadata {
    name = "my-backend"
    labels = {
      nome = "my-backend"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        nome = "my-backend"
      }
    }

    template {
      metadata {
        labels = {
          nome = "my-backend"
        }
      }

      spec {
        container {
          image = "pedroquessada/my-backend:latest"
          name  = "my-backend"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 3000
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "load-balancer-my-backend"
  }
  spec {
    selector = {
      nome = "my-backend"
    }
    port {
      port = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

# data "kubernetes_service" "DNSName" {
#     metadata {
#       name = "load-balancer-my-backend"
#     }
# }

# output "URL" {
#   value = data.kubernetes_service.DNSName.status
# }