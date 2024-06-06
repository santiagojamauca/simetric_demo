locals {
  subnet_cidrs = [
    cidrsubnet(var.cidr_block, var.subnet_bits, 0),
    cidrsubnet(var.cidr_block, var.subnet_bits, 1),
    cidrsubnet(var.cidr_block, var.subnet_bits, 2),
    cidrsubnet(var.cidr_block, var.subnet_bits, 3),
    cidrsubnet(var.cidr_block, var.subnet_bits, 4)
  ]
}

resource "aws_subnet" "eks_private_1" {
  vpc_id            = var.vpc_id
  ##cidr_block        = "10.45.0.0/23"
  cidr_block        = local.subnet_cidrs[0]
  availability_zone = "us-east-1a"

  tags = {
    Name                              = "${var.environment}-eks-private-1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "eks_private_2" {
  vpc_id            = var.vpc_id
  cidr_block        = local.subnet_cidrs[1]
  availability_zone = "us-east-1b"

  tags = {
    Name                              = "${var.environment}-eks-private-2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "eks_private_3" {
  vpc_id            = var.vpc_id
  cidr_block        = local.subnet_cidrs[2]
  availability_zone = "us-east-1c"

  tags = {
    Name                              = "${var.environment}-eks-private-3"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "eks_private_4" {
  vpc_id            = var.vpc_id
  cidr_block        = local.subnet_cidrs[3]
  availability_zone = "us-east-1d"

  tags = {
    Name                              = "${var.environment}-eks-private-4"
    "kubernetes.io/role/internal-elb" = "1"
  }
}


resource "aws_subnet" "eks_public_1" {
  vpc_id = var.vpc_id
  cidr_block = local.subnet_cidrs[4]
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.environment}-eks-public-1"
  }
}


