resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [var.route_table_id]

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "lab-s3-endpoint"
    lab  = "lab"
  }
}

# -------------------------------
# Outputs Endpoint
# -------------------------------
output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3_endpoint.id
}

output "vpc_endpoint_state" {
  value = aws_vpc_endpoint.s3_endpoint.state
}
