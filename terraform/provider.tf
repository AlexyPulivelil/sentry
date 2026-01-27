terraform {
  backend "s3" {
    bucket  = "doc-api-terraform-state"
    key     = "vm/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}