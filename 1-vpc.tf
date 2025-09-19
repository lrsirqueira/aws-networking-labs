# *********************************************************************************************#
# ******************************* VPC Resources ************************************************#
# *********************************************************************************************#

# Criação de uma VPC básica para laboratório
resource "aws_vpc" "my-first-vpc" {
  cidr_block           = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "lab-vpc"
  })
}

###############
### Outputs
###############
output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.my-first-vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block IPv4 da VPC"
  value       = aws_vpc.my-first-vpc.cidr_block
}

output "vpc_ipv6_cidr_block" {
  description = "CIDR block IPv6 da VPC"
  value       = aws_vpc.my-first-vpc.ipv6_cidr_block
}