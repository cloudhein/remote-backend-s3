terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
  }
}

provider "aws" {
  profile = "terraform-dev-role"
  region  = "ap-northeast-1"
}