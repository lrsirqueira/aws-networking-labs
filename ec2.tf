# Public EC2 Instance
resource "aws_instance" "public" {
  ami                         = "ami-08982f1c5bf93d976"
  instance_type               = "t3.micro"
  key_name                    = "latitude-laptop"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true
  
  # Automatically assign IPv6 address
  ipv6_address_count = 1

  # EBS configuration
  root_block_device {
    delete_on_termination = true
    volume_type          = "gp3"
  }

  # Metadata options
  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    instance_metadata_tags      = "disabled"
  }

  tags = {
    Name = "my-first-public-instance"
    lab  = "lab"
  }
}

# Private EC2 Instance
resource "aws_instance" "private" {
  ami                     = "ami-08982f1c5bf93d976"
  instance_type           = "t3.micro"
  key_name                = "latitude-laptop"
  subnet_id               = aws_subnet.private.id
  vpc_security_group_ids  = [aws_security_group.main.id]
  
  # Automatically assign IPv6 address
  ipv6_address_count = 1

  # EBS configuration
  root_block_device {
    delete_on_termination = true
    volume_type          = "gp3"
  }

  # Metadata options
  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    instance_metadata_tags      = "disabled"
  }

  tags = {
    Name = "my-first-private-instance"
    lab  = "lab"
  }
}