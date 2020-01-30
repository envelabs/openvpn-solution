resource "aws_subnet" "bte-openvpn-sn-a" {
  vpc_id     = "${aws_vpc.bte-openvpn-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags {
    type = "bte-openvpn-sn-a"
    env  = "prod"
    Name = "bte-openvpn-sn-a"
  }
}

resource "aws_route_table" "bte-openvpn-rt-public" {
  vpc_id = "${aws_vpc.bte-openvpn-vpc.id}"
  tags {
    type = "bte-openvpn-rt-public"
    env  = "prod"
    Name = "bte-openvpn-rt-public"
  }
}

resource "aws_route" "bte-dev-int-route" {
  route_table_id         = "${aws_route_table.bte-openvpn-rt-public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.bte-openvpn-igw.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "bte-openvpn-rt-assoc" {
  subnet_id      = "${aws_subnet.bte-openvpn-sn-a.id}"
  route_table_id = "${aws_route_table.bte-openvpn-rt-public.id}"
  lifecycle {
    ignore_changes        = ["subnet_id", "route_table_id"]
    create_before_destroy = true
  }
}

# uncomment if nat gw required
#resource "aws_eip" "bte-openvpn-nat-eip" {
#  vpc   = true
#
#  tags {
#    type = "bte-openvpn-nat-eip"
#    env = "vpn"
#    Name = "bte-openvpn-nat-eip"
#  }
#
#}

#resource "aws_nat_gateway" "bte-openvpn-nat-gw-a" {
#  allocation_id = "${aws_eip.bte-openvpn-nat-eip.id}"
#  subnet_id     = "${aws_subnet.bte-openvpn-sn-a.id}"
#
#  lifecycle {
#    create_before_destroy = true
#    ignore_changes        = ["subnet_id"]
#  }
#
#  tags {
#    type = "bte-openvpn-nat-gw-a"
#    env = "vpn"
#    Name = "bte-openvpn-nat-gw-a"
#  }
#
#}

resource "aws_eip" "bte-openvpn-srvr1-eip" {
  vpc       = true
  instance  = "${aws_instance.bte-openvpn-srvr1.id}"
  tags {
    type = "bte-openvpn-eip"
    env  = "vpn"
    Name = "bte-openvpn-eip"
  }
}
