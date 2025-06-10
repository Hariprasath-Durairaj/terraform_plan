variable "name" {
  description = "Name of the Key Vault"
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

variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "enable_rbac_authorization" {
  description = "Enable RBAC authorization on the Key Vault"
  type        = bool
  default     = true
}

variable "enabled_for_deployment" {
  description = "Allow deployment access to Key Vault"
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Allow disk encryption access"
  type        = bool
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "Allow template deployment access"
  type        = bool
  default     = false
}

variable "purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft deleted vaults"
  type        = number
  default     = 7
}

variable "default_action" {
  description = "Default action for network ACLs"
  type        = string
  default     = "Deny"
}

variable "bypass" {
  description = "Bypass for network ACLs"
  type        = string
  default     = "AzureServices"
}

variable "tags" {
  description = "Tags to apply to the Key Vault"
  type        = map(string)
  default     = {}
}
variable "public_network_access_enabled" {
  description = "Allow or deny public network access to the Key Vault"
  type        = bool
  default     = false
}
