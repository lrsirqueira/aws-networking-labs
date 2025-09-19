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