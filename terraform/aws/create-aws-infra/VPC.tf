# Recurso para criar a VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-${var.repository_name}"
  }
}

# Recurso para criar uma subnet pública
resource "aws_subnet" "public_subnet" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public-subnet-${count.index}"
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
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}