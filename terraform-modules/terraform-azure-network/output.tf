output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}