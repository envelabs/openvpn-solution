resource "aws_security_group" "bte-openvpn-sg" {
  name = "bte-openvpn-sg"
  description = "bte openvpn security group"
  vpc_id      = "${aws_vpc.bte-openvpn-vpc.id}"

  ingress {
    from_port       = "0"
    to_port         = "65535"
    protocol        = "tcp"
    cidr_blocks     = ["${var.public-ip1}"]
  }

  ingress {
    from_port       = "${var.ssh_port}"
    to_port         = "${var.ssh_port}"
    protocol        = "tcp"
    cidr_blocks     = ["${var.public-ip1}"]
  }

  ingress {
    from_port       = "${var.https_port}"
    to_port         = "${var.https_port}"
    protocol        = "tcp"
   #security_groups = ["${aws_security_group.bte-openvpn-elb-sg.id}"]
    cidr_blocks     = ["${var.public-ip1}"]
  }

  ingress {
    from_port       = "${var.openvpn_port}"
    to_port         = "${var.openvpn_port}"
    protocol        = "udp"
    cidr_blocks     = ["${var.public-ip1}"]
  }

  ingress {
    from_port       = "${var.openvpn_ui_port}"
    to_port         = "${var.openvpn_ui_port}"
    protocol        = "tcp"
    cidr_blocks     = ["${var.public-ip1}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bte-openvpn-sg"
 }
}
