provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "all" {}
terraform {
  backend "s3" {
    bucket = "bte-terraform-state"
    key = "bte-openvpn-tf-state"
    region = "us-east-1"
  }
}
