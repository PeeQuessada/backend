
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  # iam_role_arn = "arn:aws:sts::211125361403:assumed-role/voclabs/user3080190=pedro.rafael.quessada@gmail.com"
  # iam_role_name = "arn:aws:iam::211125361403:role/LabRole"

  eks_managed_node_groups = {
    my-backend = {
      min_size     = 1
      max_size     = 4
      desired_size = 2
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      instance_types = ["t2.micro"]
    }
  }
}

