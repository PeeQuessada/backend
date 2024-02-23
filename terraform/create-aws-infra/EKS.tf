# Recurso para criar o cluster EKS
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.prefix}-${var.repository_name}-${var.cluster_name}"
  role_arn = "arn:aws:iam::${var.user_id}:role/LabRole"
  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }
  depends_on = [aws_subnet.public_subnet]
}

# Recurso para criar um no em cada subrede
resource "aws_eks_node_group" "node" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    node_group_name = "${var.prefix}-${var.repository_name}-${var.cluster_name}"
    node_role_arn = "arn:aws:iam::${var.user_id}:role/LabRole"
    subnet_ids = aws_subnet.public_subnet[*].id
    scaling_config {
        desired_size = 2
        max_size = 4
        min_size = 2
    }
    depends_on = [ 
        # policies
    ]
    instance_types = ["t3.micro"]
}