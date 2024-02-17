terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# resource "aws_s3_bucket" "name" {
#   bucket = "bucket-mybackend-terraform"

#   tags = {
#     CreatedAt = "2024-02-17"
#   }
# }