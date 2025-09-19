# Configure the AWS Provider
terraform {
  required_version = ">= 1.0"

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
    lab         = ""lab
  }
}


# *********************************************************************************************#
# ******************************* Data Sources *************************************************#
# *********************************************************************************************#

# Obter zonas de disponibilidade
data "aws_availability_zones" "available" {
  state = "available"
}