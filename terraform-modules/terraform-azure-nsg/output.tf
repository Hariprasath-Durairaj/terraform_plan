output "nsg_id" {
  value = azurerm_network_security_group.this.id
}
output "aks_nsg_id" {
  value = azurerm_network_security_group.this.id
}
