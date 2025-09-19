# *********************************************************************************************#
# ******************************* Outputs *****************************************************#
# *********************************************************************************************#

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.lab_vpc.id
}

output "vpc_cidr" {
  description = "CIDR block da VPC"
  value       = aws_vpc.lab_vpc.cidr_block
}

output "subnet_id" {
  description = "ID da Subnet pública"
  value       = aws_subnet.public_subnet.id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "availability_zone" {
  description = "Zona de disponibilidade utilizada"
  value       = aws_subnet.public_subnet.availability_zone
}