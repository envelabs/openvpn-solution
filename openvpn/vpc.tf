resource "aws_vpc" "bte-openvpn-vpc" {
  cidr_block           = "${var.bte-openvpn-vpc-cidr}"
  enable_dns_hostnames = "true"
  tags {
    type = "bte-openvpn-vpc"
    env  = "prod"
    Name = "bte-openvpn-vpc"
  }
}

resource "aws_internet_gateway" "bte-openvpn-igw" {
  vpc_id = "${aws_vpc.bte-openvpn-vpc.id}"
  tags {
    type = "bte-openvpn-igw"
    env  = "prod"
    Name = "bte-openvpn-igw"
  }
}
