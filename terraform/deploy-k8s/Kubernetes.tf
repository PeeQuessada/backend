data "aws_ecr_image" "application_image" {
  repository_name = var.repository_name
  image_tag = var.image_version
}

output "name" {
  value = data.aws_ecr_image.application_image
}

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
          image = data.aws_ecr_image.application_image.image_uri
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

# resource "kubernetes_service" "LoadBalancer" {
#   metadata {
#     name = "${var.prefix}-${var.repository_name}"
#   }
#   spec {
#     selector = {
#       nome = "${var.prefix}-${var.repository_name}"
#     }
#     port {
#       port        = 3000
#       target_port = 3000
#     }
#     type = "LoadBalancer"
#   }
#}

# TESTAR
# resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
#   metadata {
#     name = "${var.prefix}-${var.repository_name}"
#   }

#   spec {
#     min_replicas = 1
#     max_replicas = 10

#     scale_target_ref {
#       kind = "Deployment"
#       name = "${var.prefix}-${var.repository_name}"
#     }

#     metric {
#       type = "Resource"

#       resource {
#         name   = "cpu"
#         target {
#           type = "Utilization"
#           average_utilization = 70
#         }
#       }
#     }
#   }
# }

# locals {
#   lb_name = kubernetes_service.LoadBalancer.status.0.load_balancer.0.ingress.0.hostname
# }

# data "aws_elb" "LoadBalancer" {
#   name = split("-", split(".", local.lb_name).0).0
# }

output "lb_hostname" {
  value = "test"#local.lb_name
}

output "lb_info" {
  value = "test" #data.aws_elb.LoadBalancer
}
