variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnets" {
  description = "Map of subnets and their address prefixes"
  type        = map(list(string))
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "subnet_network_security_group_ids" {
  description = <<EOF
Map of subnet names → NSG resource IDs.  
Every subnet you want to protect must have an entry here.  
EOF
  type    = map(string)
  default = {} 
}
