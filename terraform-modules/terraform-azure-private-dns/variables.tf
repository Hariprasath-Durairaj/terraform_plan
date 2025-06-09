variable "name" {
  description = "Name of the private DNS zone"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the DNS zone is created"
  type        = string
}

variable "link_name" {
  description = "Name of the VNet link to the private DNS zone"
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the virtual network to link"
  type        = string
}

variable "registration_enabled" {
  description = "Whether auto-registration of DNS records is enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the DNS zone"
  type        = map(string)
  default     = {}
}