output "acr_id" {
  description = "The resource ID of the Azure Container Registry"
  value       = azurerm_container_registry.this.id
}

output "acr_login_server" {
  description = "The login server URL of the Azure Container Registry"
  value       = azurerm_container_registry.this.login_server
}
