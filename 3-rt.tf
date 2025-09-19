# *********************************************************************************************#
# ******************************* Route Table Resources ****************************************#
# *********************************************************************************************#

# Route Table para a subnet pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my-first-vpc.id

  tags = merge(local.common_tags, {
    Name = "lab-public-rt"
  })
}

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


# Route Table para a subnet privada
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my-first-vpc.id

  tags = merge(local.common_tags, {
    Name = "lab-private-rt"
  })
}

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

###############
### Outputs
###############

output "public_subnet_id" {
  description = "ID da Routing Table pública"
  value       = aws_route_table.public_rt.id
}

output "public_subnet_id" {
  description = "ID da Routing Table privada"
  value       = aws_route_table.private_rt.id
}