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

# terraform {
#   backend "s3" {
#     bucket = ""
#     key = "terraform.tfstate"
#     region = "us-west-2"
#     encrypt = true
#   }
# }