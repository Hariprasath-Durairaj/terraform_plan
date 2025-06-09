resource "azurerm_container_registry" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type = var.identity_type
  }

  tags = var.tags
}
