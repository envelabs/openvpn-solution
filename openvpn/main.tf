provider "aws" {
  region = "us-east-1"
}

# for this configuration we are using the aws bucket bte-openvpn-terraform-state. Make sure your defined s3 bucket exists.
data "aws_availability_zones" "all" {}
terraform {
  backend "s3" {
    bucket = "bte-openvpn-terraform-state"
    key = "bte-openvpn-tf-state"
    region = "us-east-1"
  }
}
