# =========================
# VPC
# =========================

resource "aws_vpc" "customer_vpc_Cliff" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "customer_vpc_Cliff"
  }
}


# =========================
# INTERNET GATEWAY
# =========================

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.customer_vpc_Cliff.id

  tags = {
    Name = "custom-igw"
  }
}


# =========================
# PUBLIC SUBNET 1 - AZ1
# =========================

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.customer_vpc_Cliff.id
  cidr_block              = var.subnet_cidr_block_1
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-1-public"
  }
}


# =========================
# PUBLIC SUBNET 2 - AZ2
# =========================

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.customer_vpc_Cliff.id
  cidr_block              = var.subnet_cidr_block_2
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-2-public"
  }
}


# =========================
# PRIVATE SUBNET 3 - AZ1
# =========================

resource "aws_subnet" "subnet_3" {
  vpc_id                  = aws_vpc.customer_vpc_Cliff.id
  cidr_block              = var.subnet_cidr_block_3
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-3-private"
  }
}


# =========================
# PRIVATE SUBNET 4 - AZ2
# =========================

resource "aws_subnet" "subnet_4" {
  vpc_id                  = aws_vpc.customer_vpc_Cliff.id
  cidr_block              = var.subnet_cidr_block_4
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-4-private"
  }
}


# =========================
# PUBLIC ROUTE TABLE
# =========================

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.customer_vpc_Cliff.id

  route {
    cidr_block = var.aws_route_table
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = {
    Name = "publicRT"
  }
}


# =========================
# PUBLIC ROUTE TABLE ASSOCIATIONS
# =========================

resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.publicRT.id
}

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.publicRT.id
}


# =========================
# ELASTIC IP FOR NAT
# =========================

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "cliff-nat-eip"
  }
}


# =========================
# NAT GATEWAY
# =========================

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_1.id

  depends_on = [
    aws_internet_gateway.custom_igw
  ]

  tags = {
    Name = "cliff-nat-gateway"
  }
}


# =========================
# PRIVATE ROUTE TABLE
# =========================

resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.customer_vpc_Cliff.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "privateRT"
  }
}


# =========================
# PRIVATE ROUTE TABLE ASSOCIATIONS
# =========================

resource "aws_route_table_association" "subnet_3_association" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.privateRT.id
}

resource "aws_route_table_association" "subnet_4_association" {
  subnet_id      = aws_subnet.subnet_4.id
  route_table_id = aws_route_table.privateRT.id
}


# =========================
# ALB SECURITY GROUP
# =========================

resource "aws_security_group" "albSG" {
  name        = "albSG"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_vpc.customer_vpc_Cliff.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.aws_security_group
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.aws_security_group
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.aws_security_group
  }

  tags = {
    Name = "albSG"
  }
}


# =========================
# EC2 SECURITY GROUP
# =========================

resource "aws_security_group" "ec2SG" {
  name        = "ec2SG"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.customer_vpc_Cliff.id

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.albSG.id]
  }

  ingress {
    description     = "Allow HTTPS from ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.albSG.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.aws_security_group
  }

  tags = {
    Name = "ec2SG"
  }
}