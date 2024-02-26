resource "google_artifact_registry_repository" "repository" {
  location      = "us-central1"
  repository_id = "docker-images-rep"
  description   = "example docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }

depends_on = [ google_project_service.enable_artifact_registry_api ]
}

output "docker_repository" {
  value = google_artifact_registry_repository.repository
}

resource "google_project_service" "enable_artifact_registry_api" {
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = true
}


# output "docker_repository_url" {
#   value = google_artifact_registry_repository.repository
#   # value = aws_ecr_repository.docker_repository.repository_url
# }

