# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = "192.168.1.0/24"
  availability_zone               = "us-east-1a"
  ipv6_cidr_block                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch        = false

  tags = {
    Name = "my-first-public-subnet"
    lab  = "lab"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = "192.168.2.0/24"
  availability_zone               = "us-east-1b"
  ipv6_cidr_block                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 16)
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch        = false

  tags = {
    Name = "my-first-private-subnet"
    lab  = "lab"
  }
}