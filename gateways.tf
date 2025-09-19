# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-first-internet-gateway"
    lab  = "lab"
  }
}

# Egress Only Internet Gateway for IPv6
resource "aws_egress_only_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-first-egress-only-igw"
    lab  = "lab"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
  
  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "nat-gateway-eip"
    lab  = "lab"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "my-first-nat-gateway"
    lab  = "lab"
  }
}