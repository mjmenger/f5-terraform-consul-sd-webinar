variable create_dotenv {
  default     = false
  type        = bool
  description = "true/false flag indicating whether to create a .env file environment variable exports"
}

resource "local_file" "dotenv" {
  count = var.create_dotenv ? 1 : 0
  content  = <<EOF
bigip=${module.bigip.0.mgmtPublicIP[0]}
bigipprivateip=${module.bigip.0.private_addresses.mgmt_private.private_ip[0]}
bigipport=8443
bigipuser=admin
bigippassword=${random_string.password.result}
consul=${aws_instance.consul.public_ip}
consulprivateip=${aws_instance.consul.private_ip}
EOF
  filename = "${path.module}/.env"
}