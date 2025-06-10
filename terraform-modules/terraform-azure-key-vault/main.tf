resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  public_network_access_enabled = var.public_network_access_enabled

  enable_rbac_authorization  = var.enable_rbac_authorization
  enabled_for_deployment     = var.enabled_for_deployment
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  resource "azurerm_key_vault_secret" "appgw_pfx" {
  name         = "appgw-pfx"
  vault_uri    = module.key_vault.vault_uri
  value        = filebase64("${path.module}/certs/appgw.pfx")
  content_type = "application/x-pkcs12"
}

  network_acls {
    default_action             = var.default_action
    bypass                     = var.bypass
  }

  tags = var.tags
}
