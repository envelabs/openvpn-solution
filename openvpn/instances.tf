# NOTE: the ami id selected here for the vpn solution uses latest 2.7.5 version for openvpn as.
resource "aws_instance" "enve-openvpn-srvr1" {
  ami           = "ami-0ca1c6f31c3fb1708"
  instance_type = "t2.small"
  key_name = "enve-openvpn-key"
  vpc_security_group_ids = ["${aws_security_group.enve-openvpn-sg.id}"]
  subnet_id = "${aws_subnet.enve-openvpn-sn-a.id}"
  associate_public_ip_address = "true"
  source_dest_check = "false"

  provisioner "remote-exec" {
    inline = [
      "echo ^C",
      "sudo hostname enve-openvpn-srvr1",
      "sudo bash -c 'echo enve-openvpn-srvr1 > /etc/hostname'",
      "sudo /usr/bin/perl -pi -ne 's/(^127.0.0.1 localhost)/$1 enve-openvpn-srvr1/' /etc/hosts"
    ]

  connection {
      host = "${self.public_ip}"
      type     = "ssh"
      user     = "openvpnas"
      private_key = "${file(var.key)}"
    }
  }

  tags = {
    type = "enve-openvpn-srvr"
    env  = "prod"
    Name = "enve-openvpn-srvr1"
  }
}
