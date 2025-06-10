resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}
 resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
   for_each = var.subnet_network_security_group_ids

   subnet_id                 = azurerm_subnet.subnets[each.key].id
   network_security_group_id = each.value
 }
