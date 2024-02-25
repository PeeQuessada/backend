# Define as zonas de disponibilidade
variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-f"
}

variable "bucket_name" {
  type    = string
  default = "us-central1-my-project-buckey-2"
}

variable "prefix" {
  type    = string
  default = "us-central1"
}

variable "project_id" {
  type    = string
  default = "terraform-test-1-pedroquessada"
}

variable "image_version" {
  type    = string
  default = "test"
}