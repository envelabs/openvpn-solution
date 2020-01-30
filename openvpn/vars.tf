# vpc
variable "bte-openvpn-vpc-cidr" {
  default = "10.0.1.0/24"
}

# security groups
variable "ssh_port" {
  description = "allow ssh connections"
  default = 22
}

variable "https_port" {
  description = "allow https connections"
  default = 443
}

variable "openvpn_port" {
  description = "allow openvpn connections"
  default = 1194
}

variable "openvpn_ui_port" {
  description = "allow openvpn web admin connections"
  default = 943
}

variable "public-ip1" {
  default = "181.29.202.254/32"
}

# key
variable "key" {
  default = "/opt/keys/bte-openvpn-key.pem"
  description = "server key"
}

