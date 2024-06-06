resource "aws_nat_gateway" "main-nat-gateway-a" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.eks_private_1.id
  allocation_id     = aws_eip.main_nat_gateway_a_eip.id

  tags = {
    Name = "Main-NatGateway-AZ1"
  }
}

resource "aws_nat_gateway" "main-nat-gateway-b" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.eks_private_2.id
  allocation_id     = aws_eip.main_nat_gateway_b_eip.id

  tags = {
    Name = "Main-NatGateway-AZ2"
  }
}

resource "aws_nat_gateway" "main-nat-gateway-c" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.eks_private_3.id
  allocation_id     = aws_eip.main_nat_gateway_c_eip.id

  tags = {
    Name = "Main-NatGateway-AZ3"
  }
}

resource "aws_nat_gateway" "main-nat-gateway-d" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.eks_private_4.id
  allocation_id     = aws_eip.main_nat_gateway_d_eip.id

  tags = {
    Name = "Main-NatGateway-AZ4"
  }
}

resource "aws_eip" "main_nat_gateway_a_eip" {
  tags = {
    Name = "Main-NatGateway-AZ1-EIP"
  }
}

resource "aws_eip" "main_nat_gateway_b_eip" {
  tags = {
    Name = "Main-NatGateway-AZ2-EIP"
  }
}

resource "aws_eip" "main_nat_gateway_c_eip" {
  tags = {
    Name = "Main-NatGateway-AZ3-EIP"
  }
}

resource "aws_eip" "main_nat_gateway_d_eip" {
  tags = {
    Name = "Main-NatGateway-AZ4-EIP"
  }
}

resource "aws_eip" "main_nat_public_eip" {
  tags = {
    Name = "Main-NatGateway-Public-EIP"
  }
}

resource "aws_nat_gateway" "main-nat-public" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.eks_public_1.id
  allocation_id     = aws_eip.main_nat_public_eip.id

  tags = {
    Name = "Main-NatGateway-AZ1"
  }
}