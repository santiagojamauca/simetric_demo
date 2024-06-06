resource "aws_lb" "main-alb" {
  internal           = true
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.eks_private_1.id,
    aws_subnet.eks_private_2.id,
    aws_subnet.eks_private_3.id,
    aws_subnet.eks_private_4.id
  ]

  enable_deletion_protection = true

  tags = {
    Environment = "${var.environment}"
    Name        = "${var.environment}-alb"
  }
}

resource "aws_lb" "main-nlb" {
  internal           = true
  load_balancer_type = "network"
  subnets            = [
    aws_subnet.eks_private_1.id,
    aws_subnet.eks_private_2.id,
    aws_subnet.eks_private_3.id,
    aws_subnet.eks_private_4.id
  ]


  enable_deletion_protection = true 

  tags = {
    Environment = "${var.environment}"
    Name        = "${var.environment}-nlb"
  }
}