terraform {
  backend "s3" {
    bucket = "pedroquessadatest123456789dia23022024"
    key    = "terraform/create-app/terraform.tfstate"
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

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.auth.token
}

data "aws_eks_cluster" "eks_cluster" {
  name = "${var.prefix}-${var.repository_name}-${var.cluster_name}"
}

data "aws_eks_cluster_auth" "auth" {
  name = "${var.prefix}-${var.repository_name}-${var.cluster_name}"
}

output "aws_cluster" {
  value = data.aws_eks_cluster.eks_cluster
}
