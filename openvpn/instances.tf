resource "aws_instance" "bte-openvpn-srvr1" {
  ami           = "ami-0a2cf15ad1bf3fef4"
  instance_type = "t2.medium"
  key_name = "bte-openvpn-key"
  vpc_security_group_ids = ["${aws_security_group.bte-openvpn-sg.id}"]
  subnet_id = "${aws_subnet.bte-openvpn-sn-a.id}"
  associate_public_ip_address = "true"
  source_dest_check = "false"

  provisioner "remote-exec" {
    inline = [
      "echo ^C",
      "sudo hostname bte-openvpn-srvr1",
      "sudo bash -c 'echo bte-openvpn-srvr1 > /etc/hostname'",
      "sudo /usr/bin/perl -pi -ne 's/(^127.0.0.1 localhost)/$1 bte-openvpn-srvr1/' /etc/hosts"
    ]

  connection {
      host = "${self.public_ip}"
      type     = "ssh"
      user     = "openvpnas"
      private_key = "${file(var.key)}"
    }
  }

  tags = {
    type = "bte-openvpn-srvr"
    env  = "prod"
    Name = "bte-openvpn-srvr1"
  }
}
