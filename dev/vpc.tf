module "vpc" {
  source      = "../modules/vpc"
  cidr_block  = "10.60.0.0/16"
  environment = var.environment
}