/*

# Endpoints to get Coredns Add-Ons and push iamges to containers

# ECR-API
resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type = "Interface"
  tags = {
    "Name" = "ecr-api"
  }
}

resource "aws_vpc_endpoint_subnet_association" "ecr-api-1" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-api.id
  subnet_id        = aws_subnet.eks_private_1.id
}

resource "aws_vpc_endpoint_subnet_association" "ecr-api-2" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-api.id
  subnet_id        = aws_subnet.eks_private_2.id
}

resource "aws_vpc_endpoint_subnet_association" "ecr-api-3" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-api.id
  subnet_id        = aws_subnet.eks_private_3.id
}

resource "aws_vpc_endpoint_subnet_association" "ecr-api-4" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-api.id
  subnet_id        = aws_subnet.eks_private_4.id
}

# ECR-Docker
resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
   tags = {
    "Name" = "docker-endpoint"
   }
}

resource "aws_vpc_endpoint_subnet_association" "ecr-dkr-1" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-dkr.id
  subnet_id        = aws_subnet.eks_private_1.id
}

resource "aws_vpc_endpoint_subnet_association" "ecr-dkr-2" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-dkr.id
  subnet_id        = aws_subnet.eks_private_2.id
}

resource "aws_vpc_endpoint_subnet_association" "ecr-dkr-3" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-dkr.id
  subnet_id        = aws_subnet.eks_private_3.id
}

resource "aws_vpc_endpoint_subnet_association" "ecr-dkr-4" {
  vpc_endpoint_id  = aws_vpc_endpoint.ecr-dkr.id
  subnet_id        = aws_subnet.eks_private_4.id
}

# ECR-S3
resource "aws_vpc_endpoint" "ecr-s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  tags = {
    "Name" = "s3-gw"
   }
}

*/