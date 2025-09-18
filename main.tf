terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend S3 para armazenar o state
  backend "s3" {
    bucket         = "aws-networking-labs-terraform-state-lrsirqueira"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-aws-networking-labs"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# *********************************************************************************************#
# ******************************* Locals (Tags Comuns) ****************************************#
# *********************************************************************************************#
locals {
  common_tags = {
    Environment = "Lab"
    Owner       = "Luis"
    Project     = "AWS-Networking-Specialty"
    ManagedBy   = "Terraform"
  }
}

# *********************************************************************************************#
# ******************************* Template ****************************************************#
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

# Subnet pública
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "lab-public-subnet"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = merge(local.common_tags, {
    Name = "lab-igw"
  })
}

# Route Table para a subnet pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "lab-public-rt"
  })
}

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# *********************************************************************************************#
# ******************************* Data Sources *************************************************#
# *********************************************************************************************#

# Obter zonas de disponibilidade
data "aws_availability_zones" "available" {
  state = "available"
}

# *********************************************************************************************#
# ******************************* Outputs *****************************************************#
# *********************************************************************************************#

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.lab_vpc.id
}

output "vpc_cidr" {
  description = "CIDR block da VPC"
  value       = aws_vpc.lab_vpc.cidr_block
}

output "subnet_id" {
  description = "ID da Subnet pública"
  value       = aws_subnet.public_subnet.id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "availability_zone" {
  description = "Zona de disponibilidade utilizada"
  value       = aws_subnet.public_subnet.availability_zone
}