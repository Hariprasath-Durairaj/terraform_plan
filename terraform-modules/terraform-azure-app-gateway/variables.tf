variable "name" {
  description = "The name of the Application Gateway"
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

variable "sku_name" {
  description = "SKU name of the Application Gateway"
  type        = string
  default     = "WAF_v2"
}

variable "sku_tier" {
  description = "SKU tier"
  type        = string
  default     = "WAF_v2"
}

variable "capacity" {
  description = "Instance count of the Application Gateway"
  type        = number
  default     = 2
}

variable "subnet_id" {
  description = "Subnet ID for the Application Gateway"
  type        = string
}

variable "public_ip_id" {
  description = "Public IP ID for frontend configuration"
  type        = string
}

variable "frontend_port" {
  description = "Port for frontend listener"
  type        = number
  default     = 80
}

variable "backend_ip_addresses" {
  description = "List of backend IP addresses"
  type        = list(string)
}

variable "backend_port" {
  description = "Port on which backend instances are listening"
  type        = number
  default     = 8080
}

variable "tags" {
  description = "Tags to apply to the Application Gateway"
  type        = map(string)
  default     = {}
}

variable "firewall_policy_id" {
  description = "ID of the WAF policy"
  type        = string
  default     = null
}

variable "app_gateway_public_ip_name" {
  description = "Public IP resource name for Application Gateway"
  type        = string
  default     = null
}

variable "custom_rules" {
  description = "Custom WAF rules for Application Gateway"
  type        = list(any)
  default     = []
}

variable "https_frontend_port" {
  description = "HTTPS port for the Application Gateway"
  type        = number
  default     = 443
}

variable "backend_https_port" {
  description = "HTTPS port for backend HTTP settings"
  type        = number
  default     = 443
}

#variable "ssl_certificate_secret_id" {
#  description = "Key Vault Secret ID of the PFX certificate for HTTPS"
#  type        = string
#  default     = ""
#}

variable "ssl_certificate_name" {
  description = "Name for the SSL certificate resource inside AGW"
  type        = string
  default     = "appgw-ssl-cert"
}
variable "key_vault_secret_id" {
  type        = string
  description = "Full Key Vault Secret URI, e.g. https://<vault>.vault.azure.net/secrets/<secret-name>[/<version>]"
  default     = null
}

