################################################################################
# amazon-ebs

source "amazon-ebs" "hashistack" {
  ami_name      = "hashistack-{{timestamp}}"
  region        = var.aws_region
  instance_type = var.aws_instance_type
  source_ami_filter {
    filters {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/${var.os}-${var.os_version}-amd64-server-*"
      root-device-type    = "ebs"
    }
    # Canonical
    owners = ["099720109477"]
    most_recent = true
  }
  communicator = "ssh"
  ssh_username = "ubuntu"
  tags {
    OS = var.os
    OS_version          = var.os_version
    Name                = "HashiStack ${var.os} ${var.os_version} Vault-${var.vault_version} Consul-${var.consul_version} Nomad-${var.nomad_version} Terraform-${var.terraform_version} Packer-${var.packer_version}"
    vault_version       = var.vault_version
    consul_version      = var.consul_version
    nomad_version       = var.nomad_version
    terraform_version   = var.terraform_version
    packer_version      = var.packer_version
    oracle_version      = var.oracle_version
    vault_oracle_plugin = var.oracle_plugin_version
    Owner               = var.owner
  }
}
