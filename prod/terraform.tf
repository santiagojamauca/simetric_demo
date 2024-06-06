terraform {
  backend "s3" {
    bucket         = "-platform-tfstate-prod"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-prod"
    encrypt        = true
  }
}
