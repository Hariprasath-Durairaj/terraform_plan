resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = "standard"
  public_network_access_enabled   = false

  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  network_acls {
    default_action = Deny
    bypass         = AzureServices
  }

  tags = var.tags
}

# resource "azurerm_key_vault_secret" "appgw_pfx" {
#   name         = "appgw-pfx"
#   value        = filebase64("${path.module}/certs/appgw.pfx")
#   key_vault_id = azurerm_key_vault.this.id
#   content_type = "application/x-pkcs12"
# }
resource "azurerm_key_vault_key" "disk_encryption" {
  name         = "${var.name}-des-key"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["wrapKey", "unwrapKey"]
}

