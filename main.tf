# main.tf
# Configuração do provedor AWS
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
}


# Recurso para criar a VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks-vpc"
  }
}

#############################################

# Define as zonas de disponibilidade
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


# Recurso para criar uma subnet pública
resource "aws_subnet" "public_subnet" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24" 
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Recurso para criar o Internet Gateway
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
}

# Recurso para criar uma nova Route Table e associar à subnet pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
}

# Recurso para associar a nova Route Table à subnet pública
resource "aws_route_table_association" "public_route_association" {
  count          = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

############################################

# Recurso para criar o cluster EKS
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = "arn:aws:iam::211125361403:role/LabRole" #aws_iam_role.eks_cluster.arn
  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }
  depends_on = [aws_subnet.public_subnet]
}

# Recurso para criar um no em cada subrede
resource "aws_eks_node_group" "node" {
    cluster_name = aws_eks_cluster.my_cluster.name
    node_group_name = "my-node"
    node_role_arn = "arn:aws:iam::211125361403:role/LabRole" 
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

#####################################

# Recurso para criar um LoadBalancer público
resource "aws_lb" "my_lb" {
  name               = "my-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public_subnet[*].id 

  enable_deletion_protection = false
}

# Recurso para criar um Security Group para o LoadBalancer
resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Liberar tráfego para o LoadBalancer
resource "aws_security_group_rule" "lb_ingress" {
  security_group_id = aws_security_group.lb_sg.id
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}