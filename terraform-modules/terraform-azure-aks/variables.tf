variable "name" {
  description = "Name of the AKS cluster"
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

variable "acr_id" {
  description = "The Azure Container Registry resource ID to grant pull access to"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "node_resource_group" {
  description = "The name of the node resource group"
  type        = string
}

variable "default_node_pool" {
  description = "Configuration for the default node pool"
  type = object({
    name                        = string
    vm_size                     = string
    temporary_name_for_rotation = string 
    enable_auto_scaling         = bool
    min_count                   = number
    max_count                   = number
    max_pods                    = number
    os_disk_size_gb             = number
    type                        = string
    node_labels                 = map(string)
    tags                        = map(string)
    vnet_subnet_id              = string
    availability_zones          = list(string)
  })
}

variable "user_node_pools" {
  description = "Map of additional named user node pools"
  type = map(object({
    name               = string
    vm_size            = string
    os_disk_size_gb    = number
    node_count         = number
    max_pods           = number
    mode               = string
    node_labels        = map(string)
    vnet_subnet_id     = string
    tags               = map(string)
    availability_zones = list(string)
  }))
  default = {}
}

variable "network_plugin" {
  description = "Network plugin to use (e.g., azure or kubenet)"
  type        = string
}

variable "dns_service_ip" {
  description = "DNS service IP"
  type        = string
}

variable "service_cidr" {
  description = "Service CIDR"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Enable private AKS cluster"
  type        = bool
  default     = false
}

variable "api_server_authorized_ip_ranges" {
  description = "List of authorized IP ranges to access the API server"
  type        = list(string)
  default     = []
}

variable "enable_monitoring" {
  description = "Enable Azure Monitor (Log Analytics integration)"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}


variable "enable_ingress_application_gateway" {
  description = "Toggle AGIC addon"
  type        = bool
  default     = false
}

variable "ingress_application_gateway_id" {
  description = "App Gateway resource ID for AGIC"
  type        = string
  default     = null
}

variable "disable_local_accounts" {
  description = "Disable Kubernetes local accounts (legacy backdoor access)"
  type        = bool
  default     = false
}

variable "enable_azure_policy" {
  description = "Whether to enable the Azure Policy add-on on AKS"
  type        = bool
  default     = false
}

variable "upgrade_channel" {
  description = "AKS upgrade channel (stable | rapid | patch | node-image)"
  type        = string
  default     = "stable"
}

 variable "auto_rotate_secrets" {
   description = "Enable automatic rotation of CSI Secrets Store driver secrets"
   type        = bool
   default     = false
 }

variable "enable_disk_encryption_set" {
  description = "Whether to encrypt node OS disks with a Disk Encryption Set"
  type        = bool
  default     = false
}

variable "disk_encryption_set_id" {
  description = "Resource ID of the Azure Disk Encryption Set to use for node OS disks"
  type        = string
  default     = ""
}

variable "enable_private_cluster_public_fqdn" {
  description = "If false, disables the public FQDN on a private cluster"
  type        = bool
  default     = true
}

