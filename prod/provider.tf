provider "aws" {
  region = "us-east-1"

  allowed_account_ids = [var.aws_account]
  
  default_tags {
    tags = {
      Environment = var.environment
      Repo        = "GenerativeAI/terraform"
      Terraform   = "Yes"
    }
  }
}

