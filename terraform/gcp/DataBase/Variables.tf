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
  default = "value"
}

variable "prefix" {
  type    = string
  default = "testbd"
}

variable "project_id" {
  type    = string
  default = "testbd-415604"
}