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

variable "hashi_download_dir" {
  type        = string
  description = "The path where HashiCorp downloads will be saved."
  default     = "/data/src/hashicorp"
}

variable "bin_dir" {
  type        = string
  description = "The path where binaries will be placed."
  default     = "/usr/local/bin"
}

variable "plugins_dir" {
  type        = string
  description = "The path where Vault plugins will be placed."
  default     = "/data/vault/plugins"
}

variable "oracle_download_dir" {
  type        = string
  description = "The path where Oracle library downloads will be saved."
  default     = "/data/src/oracle"
}

variable "oracle_client_dir" {
  type        = string
  description = "The path where Oracle library will be placed."
  default     = "/usr/local"
}

variable "hashi_base_url" {
  type        = string
  description = "The URL from which HashiCorp applications can be downloaded."
  default     = "https://releases.hashicorp.com"
}

variable "vault_version" {
  type        = string
  description = "HashiCorp Vault version."
  default     = "1.9.0"
}

variable "consul_version" {
  type        = string
  description = "HashiCorp Consul version."
  default     = "1.10.4"
}

variable "nomad_version" {
  type        = string
  description = "HashiCorp Nomad version."
  default     = "1.2.1"
}

variable "terraform_version" {
  type        = string
  description = "HashiCorp Terraform version."
  default     = "1.0.11"
}

variable "packer_version" {
  type        = string
  description = "HashiCorp Packer version."
  default     = "1.7.8"
}

variable "consul-template_version" {
  type        = string
  description = "HashiCorp Consul-Template version."
  default     = "0.27.2"
}

variable "envconsul_version" {
  type        = string
  description = "HashiCorp Envconsul version."
  default     = "0.12.1"
}

variable "boundary_version" {
  type        = string
  description = "HashiCorp Boundary version."
  default     = "0.7.1"
}

variable "waypoint_version" {
  type        = string
  description = "HashiCorp Waypoint version."
  default     = "0.6.2"
}

variable "oracle_version" {
  type        = string
  description = "Oraclient client library version."
  default     = "21.1"
}

variable "oracle_plugin_version" {
  type        = string
  description = "Vault Oracle Plugin version."
  default     = "0.4.2"
}

variable "venafi_plugin_version" {
  type        = string
  description = "Vault Venafi Plugin version."
  default     = "0.9.1"
}

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
