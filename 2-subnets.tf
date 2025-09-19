# *********************************************************************************************#
# ******************************* Subnet Resources *********************************************#
# *********************************************************************************************#

# Subnet pública
resource "aws_subnet" "public_subnet" {
  vpc_id                          = aws_vpc.my-first-vpc.id
  cidr_block                      = "192.168.1.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.my-first-vpc.ipv6_cidr_block, 8, 1)
  availability_zone               = "us-east-1a"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(local.common_tags, {
    Name = "my-first-public-subnet"
  })
}

# Subnet privada
resource "aws_subnet" "private_subnet" {
  vpc_id                          = aws_vpc.my-first-vpc.id
  cidr_block                      = "192.168.2.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.my-first-vpc.ipv6_cidr_block, 8, 2)
  availability_zone               = "us-east-1b"
  assign_ipv6_address_on_creation = true

  tags = merge(local.common_tags, {
    Name = "my-first-private-subnet"
  })
}


###############
### Outputs
###############


# Subnet Outputs
output "public_subnet_id" {
  description = "ID da subnet pública"
  value       = aws_subnet.public_subnet.id
}

output "public_subnet_ipv6_cidr" {
  description = "CIDR block IPv6 da subnet pública"
  value       = aws_subnet.public_subnet.ipv6_cidr_block
}

output "private_subnet_id" {
  description = "ID da subnet privada"
  value       = aws_subnet.private_subnet.id
}

output "private_subnet_ipv6_cidr" {
  description = "CIDR block IPv6 da subnet privada"
  value       = aws_subnet.private_subnet.ipv6_cidr_block
}