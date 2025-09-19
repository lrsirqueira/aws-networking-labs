# outputs.tf

# VPC Outputs
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

# Subnet Outputs
output "public_subnet_id" {
  description = "ID da subnet pública"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID da subnet privada"
  value       = aws_subnet.private_subnet.id
}

output "public_subnet_ipv6_cidr" {
  description = "CIDR block IPv6 da subnet pública"
  value       = aws_subnet.public_subnet.ipv6_cidr_block
}

output "private_subnet_ipv6_cidr" {
  description = "CIDR block IPv6 da subnet privada"
  value       = aws_subnet.private_subnet.ipv6_cidr_block
}