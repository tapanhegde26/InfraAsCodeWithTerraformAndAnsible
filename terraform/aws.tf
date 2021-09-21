# Specify the provider and access details
#provider "aws" {
#  version = "~> 3.59"
#}
terraform {
  required_providers {
    mycloud = {
      source  = "hashicorp/aws"
      version = "~> 3.59"
    }
  }
}
