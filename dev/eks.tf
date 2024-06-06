module "eks" {
  source                  = "../modules/eks"
  vpc_id                  = module.vpc.vpc_id
  environment             = var.environment
  cidr_block              = var.cidr_block
  aws_account             = var.aws_account
  vpc_internet_gateway_id = module.vpc.internet_gateway_id
}