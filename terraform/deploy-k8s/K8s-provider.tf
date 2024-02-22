data "aws_eks_cluster" "eks_cluster" {
  name = "${var.prefix}-${var.repository_name}-${var.cluster_name}"
}

output "aws_cluster" {
  value = data.aws_eks_cluster.eks_cluster
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${var.prefix}-${var.repository_name}-${var.cluster_name}"]
    command     = "aws"
  }
}