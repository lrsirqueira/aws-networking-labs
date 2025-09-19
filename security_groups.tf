# Security Group
resource "aws_security_group" "main" {
  name_prefix = "launch-wizard-1"
  description = "launch-wizard-1 created 2025-09-19T12:11:39.768Z"
  vpc_id      = aws_vpc.main.id

  # SSH access
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # ICMP
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my-security-group"
    lab  = "lab"
  }
}