provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}
resource "aws_instance" "example" {
  ami = "ami-08c40ec9ead489470" #ubuntu 22.04 LTS
  instance_type = "t2.micro"

  tags = {
    "Name" = "terraform-example"
  }
}