terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "kubernetes-terraform-tfstate-05-01-2026"
    key = "terraform.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}