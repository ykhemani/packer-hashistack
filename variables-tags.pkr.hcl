variable "owner" {
  type        = string
  description = "The person or group who launched these resources.  Must be a valid HashiCorp email prefix."
}

variable "se-region" {
  type        = string
  description = "The region the owner belongs to (e.g. AMER - Northeast E1 - R2)."
}

variable "purpose" {
  type        = string
  description = "Detailed description for why these resources are being launched."
}

variable "ttl" {
  type        = string
  description = "Time in hours from the launch that a resource can be stopped/terminated. Use -1 for permanent resources."
  default     = "48"
}

variable "hc-internet-facing" {
  type        = string
  description = "(true|false). Whether a resource such as an S3 bucket is intended to be internet facing. If this value is not set and the resource is externally facing, it will be removed from public facing and/or terminated."
  default     = "false"
}

variable "creator" {
  type        = string
  description = "Valid email address of the person who created these resources.  Owner is usually the contact, but in the case where the creator and owner of the resources are different, this allows for helping find the creator."
}

variable "customer" {
  type        = string
  description = "For resources created for a customer project, this can help us realize cost of sale."
  default     = ""
}

variable "tfe-workspace" {
  type        = string
  description = "(org/workspace) Makes it easier to find where resources were created."
  default     = ""
}

variable "lifecycle-action" {
  type        = string
  description = "(stop|terminate) By default all instances exceptional resources are terminated. This allows them to be stopped instead where that’s a capability."
  default     = "stop"
}

variable "config-as-code" {
  type        = string
  description = "This is a potential replacement for the mandatory 'terraform' tag and allows for some flexibility to surface other infrastructure provisioning tools."
  default     = "terraform"
}

variable "repo" {
  type        = string
  description = "If a config-as-code value is set, the repository that holds the code used to create this resource."
  default     = ""
}
