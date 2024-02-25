resource "kubernetes_deployment" "Application" {
  metadata {
    name = "${var.prefix}-${var.project_id}"
    labels = {
      nome = "${var.prefix}-${var.project_id}"
    }

  }

  spec {
    replicas = 2

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
    }

    selector {
      match_labels = {
        nome = "${var.prefix}-${var.project_id}"
      }
    }

    template {
      metadata {
        labels = {
          nome = "${var.prefix}-${var.project_id}"
        }
      }

      spec {
        container {
          image = "us-central1-docker.pkg.dev/backend-test1-415414/docker-images-rep/my-backend"
          name  = "${var.prefix}-${var.project_id}"

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

            initial_delay_seconds = 600
            period_seconds        = 300
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "${var.prefix}-${var.project_id}"
  }
  spec {
    selector = {
      nome = "${var.prefix}-${var.project_id}"
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

locals {
  lb_name = kubernetes_service.LoadBalancer.status.0.load_balancer.0.ingress.0.hostname
}

output "lb_hostname" {
  value = local.lb_name
}

output "lb_info" {
  value = kubernetes_service.LoadBalancer
}