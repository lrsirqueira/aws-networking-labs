# VPC
resource "aws_vpc" "main" {
  cidr_block                       = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "my-first-vpc"
    lab  = "lab"
  }
}