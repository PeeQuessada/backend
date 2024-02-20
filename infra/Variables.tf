# Define as zonas de disponibilidade
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "region" {
  type = string
  default = "us-east-1"
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

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "session_token" {
  type = string
}

variable "role" {
  type = string
}

variable "profile" {
  type = string
  default = "arn:aws:sts::211125361403:assumed-role/voclabs/user3080190=pedro.rafael.quessada@gmail.com"
}

variable "image" {
  type = string
}