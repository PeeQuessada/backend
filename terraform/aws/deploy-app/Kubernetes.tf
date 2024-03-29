resource "kubernetes_deployment" "Application" {
  metadata {
    name = "${var.prefix}-${var.repository_name}"
    labels = {
      nome = "${var.prefix}-${var.repository_name}"
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
        nome = "${var.prefix}-${var.repository_name}"
      }
    }

    template {
      metadata {
        labels = {
          nome = "${var.prefix}-${var.repository_name}"
        }
      }

      spec {
        container {
          image = "${var.user_id}.dkr.ecr.${var.region}.amazonaws.com/${var.repository_name}:${var.image_version}"
          name  = "${var.prefix}-${var.repository_name}"

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
    name = "${var.prefix}-${var.repository_name}"
  }
  spec {
    selector = {
      nome = "${var.prefix}-${var.repository_name}"
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

data "aws_elb" "LoadBalancer" {
  name = split("-", split(".", local.lb_name).0).0
}

# data "aws_ecr_image" "application_image" {
#   repository_name = var.repository_name
#   image_tag       = var.image_version
# }

output "lb_hostname" {
  value = local.lb_name
}

output "lb_info" {
  value = data.aws_elb.LoadBalancer
}

# output "image_name" {
#   value = data.aws_ecr_image.application_image
# }