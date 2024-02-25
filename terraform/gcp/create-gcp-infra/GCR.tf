resource "google_artifact_registry_repository" "repository" {
  location      = var.region
  repository_id = "${var.prefix}-${var.project_id}"
  description   = "example docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}

output "docker_repository" {
  value = google_artifact_registry_repository.repository
}

# output "docker_repository_url" {
#   value = google_artifact_registry_repository.repository
#   # value = aws_ecr_repository.docker_repository.repository_url
# }

