################################################################################
# AWS Specific
variable "aws_region_us_east_1" {
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

variable "source_ami_filter_virtualization_type" {
  type        = string
  description = "Source AMI virtualization type filter."
  default     = "hvm"
}

variable "source_ami_filter_name" {
  type        = string
  description = "Source AMI name filter."
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "source_ami_filter_rooot_device_type" {
  type        = string
  description = "Source AMI root device type"
  default     = "ebs"
}

variable "source_ami_owners" {
  type        = list(string)
  description = "Source AMI owner. Default is Canonical."
  default     = ["099720109477"]
}

variable "amazon_communicator" {
  type        = string
  description = "Communicator for Amazon builder."
  default     = "ssh"
}

variable "amazon_ssh_username" {
  type        = string
  description = "SSH username for Amazon builder."
  default     = "ubuntu"
  #default     = "ec2-user"
}

variable "amazon_image_name" {
  type        = string
  description = "Value to use for naming Amazon image."
  default     = "Ubuntu Focal (22.04) Golden Image"
}

################################################################################

variable "os" {
  type        = string
  description = "OS."
  default     = "ubuntu-jammy"
}

variable "os_version" {
  type        = string
  description = "OS Version."
  default     = "22.04"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming image"
  default     = "hashistack"
}

################################################################################
# HCP Packer

variable "bucket_name" {
  type        = string
  description = "The image name when published to the HCP Packer registry. Will be overwritten if HCP_PACKER_BUCKET_NAME is set."
  default     = "ubuntu-jammy-hashistack-slim"
}

variable "bucket_description" {
  type        = string
  description = "The image description. Useful to provide a summary about the image. The description will appear at the image's main page and will be updated whenever it is changed and a new build is pushed to the HCP Packer registry. Should contain a maximum of 255 characters."
  default     = "This image is based on Ubuntu 22.04 and includes software HashiCorp, Docker, minikube, kubectl and other software."
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

variable "hashi_base_url" {
  type        = string
  description = "The URL from which HashiCorp applications can be downloaded."
  default     = "https://releases.hashicorp.com"
}

variable "envconsul_version" {
  type        = string
  description = "HashiCorp Envconsul version."
  default     = "0.13.0"
}

################################################################################
variable "tags" {
  type        = map(string)
  description = "Tags to apply to images."
  default     = {}
}