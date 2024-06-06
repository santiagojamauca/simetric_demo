# Create the transit gateway attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "main-vpc" {
subnet_ids         = [
    aws_subnet.eks_private_1.id,
    aws_subnet.eks_private_2.id,
    aws_subnet.eks_private_3.id,
    aws_subnet.eks_private_4.id
  ]
  transit_gateway_id = "tgw-0c2251318169a46ae" # Transit Gateway shared from other account
  vpc_id             = var.vpc_id

  tags = {
    "Name" = "main-vpc"
  }
}