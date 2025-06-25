variable "name" {
  description = "Name of the NAT Gateway"
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
  description = "SKU for the NAT Gateway (Standard only)"
  type        = string
  default     = "Standard"
}

variable "public_ip_id" {
  description = "ID of the public IP to associate with NAT Gateway"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate the NAT Gateway with"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the NAT Gateway"
  type        = map(string)
  default     = {}
}