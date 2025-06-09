variable "name" {
  description = "The name of the Bastion host"
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

variable "subnet_id" {
  description = "ID of the subnet where Bastion will be deployed"
  type        = string
}

variable "public_ip_id" {
  description = "ID of the Public IP address assigned to Bastion"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Bastion host"
  type        = map(string)
  default     = {}
}