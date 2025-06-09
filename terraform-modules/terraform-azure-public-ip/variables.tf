variable "name" {
  description = "The name of the Public IP"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "allocation_method" {
  description = "Allocation method for the Public IP (Static or Dynamic)"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "The SKU of the Public IP (Basic or Standard)"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A map of tags to apply to the Public IP"
  type        = map(string)
  default     = {}
}