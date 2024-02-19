terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
  # profile = "default"
  
  # access_key = var.access_key
  # secret_key = var.secret_key
  # token = var.session_token

  allowed_account_ids = ["211125361403"]
  assume_role {
    role_arn= "arn:aws:sts::211125361403:assumed-role/voclabs/user3080190=pedro.rafael.quessada@gmail.com"
  }
}

data "aws_eks_cluster" "my-backend" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "my-backend" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.my-backend.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.my-backend.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.my-backend.token
}