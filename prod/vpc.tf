module "vpc" {
  source      = "../modules/vpc"
  cidr_block  = "10.45.0.0/16"
  environment = var.environment
}