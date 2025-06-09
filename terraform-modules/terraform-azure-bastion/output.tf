output "bastion_id" {
  description = "The ID of the Bastion host"
  value       = azurerm_bastion_host.this.id
}