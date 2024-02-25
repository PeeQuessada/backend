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
  default = "us-central1-my-project-buckey-3"
}

variable "prefix" {
  type    = string
  default = "tf"
}

variable "project_id" {
  type    = string
  default = "backend-test1-415414"
}

variable "image_version" {
  type    = string
  default = "test"
}