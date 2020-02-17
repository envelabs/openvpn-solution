resource "aws_subnet" "enve-openvpn-sn-a" {
  vpc_id     = "${aws_vpc.enve-openvpn-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    type = "enve-openvpn-sn-a"
    env  = "prod"
    Name = "enve-openvpn-sn-a"
  }
}

resource "aws_route_table" "enve-openvpn-rt-public" {
  vpc_id = "${aws_vpc.enve-openvpn-vpc.id}"
  tags = {
    type = "enve-openvpn-rt-public"
    env  = "prod"
    Name = "enve-openvpn-rt-public"
  }
}

resource "aws_route" "enve-dev-int-route" {
  route_table_id         = "${aws_route_table.enve-openvpn-rt-public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.enve-openvpn-igw.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "enve-openvpn-rt-assoc" {
  subnet_id      = "${aws_subnet.enve-openvpn-sn-a.id}"
  route_table_id = "${aws_route_table.enve-openvpn-rt-public.id}"
  lifecycle {
    ignore_changes        = ["subnet_id", "route_table_id"]
    create_before_destroy = true
  }
}

# uncomment if nat gw required
#resource "aws_eip" "enve-openvpn-nat-eip" {
#  vpc   = true
#
#  tags = {
#    type = "enve-openvpn-nat-eip"
#    env = "vpn"
#    Name = "enve-openvpn-nat-eip"
#  }
#
#}

#resource "aws_nat_gateway" "enve-openvpn-nat-gw-a" {
#  allocation_id = "${aws_eip.enve-openvpn-nat-eip.id}"
#  subnet_id     = "${aws_subnet.enve-openvpn-sn-a.id}"
#
#  lifecycle {
#    create_before_destroy = true
#    ignore_changes        = ["subnet_id"]
#  }
#
#  tags = {
#    type = "enve-openvpn-nat-gw-a"
#    env = "vpn"
#    Name = "enve-openvpn-nat-gw-a"
#  }
#
#}

resource "aws_eip" "enve-openvpn-srvr1-eip" {
  vpc       = true
  instance  = "${aws_instance.enve-openvpn-srvr1.id}"
  tags = {
    type = "enve-openvpn-eip"
    env  = "vpn"
    Name = "enve-openvpn-eip"
  }
}
