resource "aws_route_table" "main-public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.vpc_internet_gateway_id
  }

  tags = {
    "Name" = "${var.environment}"
  }
}

resource "aws_route_table" "main-private" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main-nat-public.id
  }

  tags = {
    "Name" = "${var.environment}"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.main-private.id
}

## Subnet Associations to main route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.eks_private_1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.eks_private_2.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.eks_private_3.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.eks_private_4.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.eks_public_1.id
  route_table_id = aws_route_table.main-public.id
}

