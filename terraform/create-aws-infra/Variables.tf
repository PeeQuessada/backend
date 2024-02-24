# Define as zonas de disponibilidade
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
# Define as zonas de disponibilidade
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "prefix" {
  type    = string
  default = "test"
}

variable "repository_name" {
  type    = string
  default = "test"
}

variable "cluster_name" {
  type    = string
  default = "test"
}

variable "image_version" {
  type    = string
  default = "test"
}

variable "bucket_name" {
  type    = string
  default = "pedroquessadatest123456789dia23022024"
}

variable "user_id" {
  type    = string
  default = "211125361403"
}

variable "access_key" {
  type = string
  default = "ASIATCKANLL55E65DEN7"
}

variable "secret_key" {
  type = string
  default = "964gtSKpn0+MU43vaq5FeryEHlM5p5/Sm1OuJCTJ"
}

variable "session_token" {
  type = string
  default = "FwoGZXIvYXdzEKn//////////wEaDLE19YHO9QEdl93iRiLQAb5AuvdVzzf6B7wFXJ7Ntv29BPLLQ3jy9MJwH5tqxMoiw3B3bYQT1oGlocdwK6pQ3A49MXGjTm+LPwK9WnU6w6kMQl4USD7AWvEIa12b4DLMB9zHd1wLw/QB8SE9+ORK2xDi1O9RshI6iYzLGmKL0XAlhoiSHrj34a4y1ZsYbDD1yyjv3JMF+2w//TJJeF9z2dOj3AXsAILo3LOOfKggHzz78zZlEphg9DjoZwMm6o9ZpxrMRCNUZw1tsNUtIn1Or4yt8Qiw3zjlKphxQgp+oFQo/8zkrgYyLaJF5uNEwH7MAwHTt73d7rNRIkgMbXmj11tBB/RcdzeyVbhH5gQ6rm9DYzWrNw=="
}