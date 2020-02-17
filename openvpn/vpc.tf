resource "aws_vpc" "enve-openvpn-vpc" {
  cidr_block           = "${var.enve-openvpn-vpc-cidr}"
  enable_dns_hostnames = "true"
  
  tags = {
    type = "enve-openvpn-vpc"
    env  = "prod"
    Name = "enve-openvpn-vpc"
  }
}

resource "aws_internet_gateway" "enve-openvpn-igw" {
  vpc_id = "${aws_vpc.enve-openvpn-vpc.id}"

  tags = {
    type = "enve-openvpn-igw"
    env  = "prod"
    Name = "enve-openvpn-igw"
  }
}
