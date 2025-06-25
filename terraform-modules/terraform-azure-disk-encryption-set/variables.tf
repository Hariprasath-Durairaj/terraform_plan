variable "name" {
  description = "The name of the Disk Encryption Set"
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

variable "key_vault_key_id" {
  description = "The ID of the Key Vault key used for encryption"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Disk Encryption Set"
  type        = map(string)
  default     = {}
}