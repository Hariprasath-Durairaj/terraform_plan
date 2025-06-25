variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "nsg_security_rules" {
  description = "Security rules for the NSG"
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
variable "tags" {
  description = "Tags to apply to the NSG"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Optional subnet ID to associate this NSG with"
  type        = string
  default     = null
}
