###############################################################################
# variables.tf — QA Environment (AGIC-only, enterprise tag standard)         #
###############################################################################

############################
# 1. Global
############################
variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource-group name that hosts the QA stack"
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant GUID"
  type        = string
}

variable "tags" {
  description = "Standard enterprise tags applied to every resource"
  type        = map(string)
  default = {
    environment  = "QA"
    businessUnit = "Corp-IT"
    application  = "DHDP"
    owner        = "hp@corp.com"
    managedBy    = "Terraform"
    createdBy    = "AzureDevOps"
    criticality  = "Standard"
  }
}

############################
# 2. Virtual Network & NAT
############################
variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "address_space" {
  description = "CIDR blocks for the VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet CIDR map (e.g., aks, appgw)"
  type        = map(list(string))
}

variable "nat_gateway_name" {
  description = "NAT Gateway name"
  type        = string
}

############################
# 3. Network Security
############################
variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "nsg_security_rules" {
  description = "Custom NSG rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

############################
# 4. Private DNS
############################
variable "private_dns_name" {
  description = "Private DNS Zone FQDN"
  type        = string
}

variable "private_dns_link_name" {
  description = "Link name for VNet ↔ DNS"
  type        = string
}

############################
# 5. Key Vault & Encryption
############################
variable "key_vault_name" {
  description = "Key Vault name"
  type        = string
}

variable "des_name" {
  description = "Disk Encryption Set name"
  type        = string
}

variable "key_vault_key_id" {
  description = "Customer-managed key URI"
  type        = string
}

############################
# 6. Container Registry & Backup
############################
variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "backup_vault_name" {
  description = "Recovery Services vault name"
  type        = string
}

############################
# 7. AKS configuration
############################
variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS API server"
  type        = string
}

variable "kubernetes_version" {
  description = "Desired Kubernetes version"
  type        = string
}

variable "node_resource_group" {
  description = "Managed resource-group for AKS nodes"
  type        = string
}

variable "default_node_pool" {
  description = "System node-pool settings"
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    max_pods            = number
    os_disk_size_gb     = number
    node_labels         = map(string)
    vnet_subnet_id      = string
    availability_zones  = optional(list(string))
  })
}

variable "user_node_pools" {
  description = "Map of user-defined node pools"
  type        = map(any)
}

variable "network_plugin" {
  description = "Network plugin (azure | kubenet)"
  type        = string
}

variable "dns_service_ip" {
  description = "Cluster DNS service IP"
  type        = string
}

variable "service_cidr" {
  description = "Kubernetes Service CIDR"
  type        = string
}

variable "api_server_authorized_ip_ranges" {
  description = "CIDRs allowed to reach the AKS control plane"
  type        = list(string)
  default     = []
}

############################
# 8. Log Analytics
############################
variable "log_analytics_name" {
  description = "Log Analytics workspace name"
  type        = string
}

variable "log_retention" {
  description = "Retention period (days) for Log Analytics"
  type        = number
}

############################
# 9. Application Gateway & WAF
############################
variable "app_gateway_name" {
  description = "Application Gateway name"
  type        = string
}

variable "app_gateway_subnet_name" {
  description = "Subnet key that hosts the App Gateway"
  type        = string
}

variable "app_gateway_frontend_port" {
  description = "Frontend HTTP port"
  type        = number
}

variable "app_gateway_backend_port" {
  description = "Backend port forwarded by App Gateway"
  type        = number
}

variable "app_gateway_backend_ip_addresses" {
  description = "Initial backend IPs (AGIC will overwrite)"
  type        = list(string)
  default     = []
}

variable "app_gateway_sku_name" {
  description = "SKU name (e.g., WAF_v2)"
  type        = string
}

variable "app_gateway_sku_tier" {
  description = "SKU tier"
  type        = string
}

variable "app_gateway_capacity" {
  description = "Instance count for App Gateway"
  type        = number
}

variable "app_gateway_tags" {
  description = "Extra tags for Application Gateway"
  type        = map(string)
  default     = {}
}

variable "custom_rules" {
  description = "Custom WAF rules (optional)"
  type        = list(any)
  default     = []
}

############################
# 10. Convenience variables
############################
variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Whether the AKS cluster should be private"
  type        = bool
  default     = false
}




