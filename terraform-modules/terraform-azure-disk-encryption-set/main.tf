resource "azurerm_disk_encryption_set" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }

  key_vault_key_id = var.key_vault_key_id

  tags = var.tags
}