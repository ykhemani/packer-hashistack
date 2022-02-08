################################################################################
# AWS Specific
variable "aws_region" {
  type        = string
  description = "AWS Region in which to build image."
  default     = "us-east-1"
}

variable "aws_instance_type" {
  type        = string
  description = "Instance on which to build image."
  default     = "t2.micro"
}

variable "encrypt_boot" {
  type        = bool
  description = "Encrypt boot volume?"
  default     = false
}

variable "aws_kms_key_id" {
  type        = string
  description = "ARN for KMS Key ID to use for encrypting volume."
  default     = ""
}

################################################################################
variable "vault_version" {
  type        = string
  description = "HashiCorp Vault version."
  default     = "1.9.3+ent"
}

variable "consul_version" {
  type        = string
  description = "HashiCorp Consul version."
  default     = "1.11.2+ent"
}

variable "nomad_version" {
  type        = string
  description = "HashiCorp Nomad version."
  default     = "1.2.5+ent"
}

variable "terraform_version" {
  type        = string
  description = "HashiCorp Terraform version."
  default     = "1.1.5"
}

variable "packer_version" {
  type        = string
  description = "HashiCorp Packer version."
  default     = "1.7.10"
}

variable "consul-template_version" {
  type        = string
  description = "HashiCorp Consul-Template version."
  default     = "0.27.2"
}

variable "boundary_version" {
  type        = string
  description = "HashiCorp Boundary version."
  default     = "0.7.4"
}

variable "waypoint_version" {
  type        = string
  description = "HashiCorp Waypoint version."
  default     = "0.7.1"
}

################################################################################

variable "os" {
  type        = string
  description = "OS."
  default     = "ubuntu-bionic"
}

variable "os_version" {
  type        = string
  description = "OS Version."
  default     = "18.04"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming image"
  default     = "hashistack"
}

################################################################################
