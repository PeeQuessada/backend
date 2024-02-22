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
          image = "${data.aws_ecr_image.application_image.image_uri}:${var.image_version}"
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