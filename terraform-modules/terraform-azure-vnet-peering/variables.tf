variable "name" {
  description = "Name of the VNet peering"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the local VNet"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the local VNet"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "ID of the remote VNet"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow access between VNets"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic"
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit from local VNet"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Use remote VNet's gateway"
  type        = bool
  default     = false
}