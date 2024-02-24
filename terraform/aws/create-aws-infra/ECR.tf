resource "aws_ecr_repository" "docker_repository" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.docker_repository.repository_url
}

output "ecr_repository_test" {
  value = aws_ecr_repository.docker_repository
}