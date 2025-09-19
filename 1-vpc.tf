# *********************************************************************************************#
# ******************************* VPC Resources ************************************************#
# *********************************************************************************************#

# Criação de uma VPC básica para laboratório
resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "lab-vpc"
  })
}