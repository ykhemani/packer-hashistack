################################################################################
# amazon-ebs

locals {
  encrypted = var.encrypt_boot && var.aws_kms_key_id != "" ? "encrypted-" : ""

  tags = {
    OS         = var.os
    OS_version = var.os_version
    Name       = "HashiStack ${var.os} ${var.os_version}"

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

source "amazon-ebs" "hashistack-aws-us-east-1" {
  ami_name      = "${var.prefix}-${local.encrypted}{{timestamp}}"
  region        = var.aws_region_us_east_1
  instance_type = var.aws_instance_type
  encrypt_boot  = var.encrypt_boot
  kms_key_id    = var.encrypt_boot ? var.aws_kms_key_id : ""
  source_ami_filter {
    filters = {
      #name                = "ubuntu/images/hvm-ssd/${var.os}-${var.os_version}-amd64-server-*"
      virtualization-type = var.source_ami_filter_virtualization_type
      name                = var.source_ami_filter_name
      root-device-type    = var.source_ami_filter_rooot_device_type
    }
    # Canonical
    owners      = var.source_ami_owners
    most_recent = true
  }
  communicator = var.amazon_communicator
  ssh_username = var.amazon_ssh_username
  tags         = local.tags
}
