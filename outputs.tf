# *********************************************************************************************#
# ******************************* Outputs *****************************************************#
# *********************************************************************************************#

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.my-first-vpc.id
}

output "vpc_cidr" {
  description = "CIDR block da VPC"
  value       = aws_vpc.my-first-vpc.cidr_block
}

output "availability_zone" {
  description = "Zona de disponibilidade utilizada"
  value       = aws_subnet.public_subnet.availability_zone
}