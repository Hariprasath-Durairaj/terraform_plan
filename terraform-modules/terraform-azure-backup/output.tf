output "vault_id" {
  description = "The ID of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.this.id
}

output "vault_name" {
  description = "The name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.this.name
}