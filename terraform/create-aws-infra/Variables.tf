# Define as zonas de disponibilidade
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "region" {
  type = string
}

variable "prefix" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "image_version" {
  type = string
}

variable "user_id" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "session_token" {
  type = string
}