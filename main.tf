resource "aws_default_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Default VPC"
  }
}