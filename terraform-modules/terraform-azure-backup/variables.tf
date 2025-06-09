variable "name" {
  description = "The name of the Recovery Services Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU of the Recovery Services Vault (e.g., Standard)"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A map of tags to apply to the vault"
  type        = map(string)
  default     = {}
}