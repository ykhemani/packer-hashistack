################################################################################
# amazon-ebs

locals {
  encrypted = var.encrypt_boot && var.aws_kms_key_id != "" ? "encrypted-" : ""
}

source "amazon-ebs" "hashistack" {
  ami_name      = "${var.prefix}-${local.encrypted}{{timestamp}}"
  region        = var.aws_region
  instance_type = var.aws_instance_type
  encrypt_boot  = var.encrypt_boot
  kms_key_id    = var.encrypt_boot ? var.aws_kms_key_id : ""
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/${var.os}-${var.os_version}-amd64-server-*"
      root-device-type    = "ebs"
    }
    # Canonical
    owners      = ["099720109477"]
    most_recent = true
  }
  communicator = "ssh"
  ssh_username = "ubuntu"
  tags = {
    OS                      = var.os
    OS_version              = var.os_version
    Name                    = "HashiStack ${var.os} ${var.os_version} Vault-${var.vault_version} Consul-${var.consul_version} Nomad-${var.nomad_version} Terraform-${var.terraform_version} Packer-${var.packer_version}"
    vault_version           = var.vault_version
    consul_version          = var.consul_version
    nomad_version           = var.nomad_version
    boundary_version        = var.boundary_version
    terraform_version       = var.terraform_version
    packer_version          = var.packer_version
    consul-template_version = var.consul-template_version
    envconsul_version       = var.envconsul_version
    oracle_version          = var.oracle_version
    vault_oracle_plugin     = var.oracle_plugin_version
    vault_venafi_plugin     = var.venafi_plugin_version

    owner              = var.owner
    ttl                = var.ttl
    se-region          = var.se-region
    purpose            = var.purpose
    ttl                = var.ttl
    hc-internet-facing = var.hc-internet-facing
    creator            = var.creator
    customer           = var.customer
    config-as-code     = var.config-as-code
    repo               = var.repo
  }
}
