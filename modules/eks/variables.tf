variable "vpc_id" {
  type = string
}

variable "vpc_internet_gateway_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr_block" {
  description = "VPC cidr_block"
  type        = string
}

variable "subnet_bits" {
  description = "The number of bits to use for the subnet CIDR blocks"
  type        = number
  default     = 7 # This will create /23 subnets
}

variable "aws_account" {
  description = "The AWS account"
  type        = string
}
