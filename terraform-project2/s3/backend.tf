terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10"
    }
  }
  required_version = ">= 1.12"
}

provider "aws" {
  region = "us-east-1"
}
