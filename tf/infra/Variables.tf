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

variable "profile" {
  type = string
  default = "arn:aws:sts::211125361403:assumed-role/voclabs/user3080190=pedro.rafael.quessada@gmail.com"
}

variable "role" {
  type = string
  default = "arn:aws:iam::211125361403:role/LabRole"
}
