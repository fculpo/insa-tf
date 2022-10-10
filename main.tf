terraform {
  backend "s3" {
    profile        = "insa"
    bucket         = "fculpo-tfstate-insa"
    key            = "terraform.tfstate"
    #dynamodb_table = "terraform-lock"
    region         = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "insa"
}

resource "aws_s3_bucket" "osef" {
  bucket = "fculpo-fsabajkdfjkasdfkjbkbjasd"
}
