resource "azurerm_network_security_group" "this" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = { for idx, rule in var.nsg_security_rules : idx => rule }
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}   # <--- THIS CLOSING BRACE MUST BE PRESENT!


#resource "azurerm_subnet_network_security_group_association" "this" {
#  subnet_id                 = var.subnet_id
#  network_security_group_id = azurerm_network_security_group.this.id
#}
