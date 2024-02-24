terraform {
  backend "s3" {
    bucket = "pedrohrq070519871227pedrohrq070519871227test1"
    key    = "terraform/create-infra/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWWS Provider
provider "aws" {
  region = var.region

  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}
