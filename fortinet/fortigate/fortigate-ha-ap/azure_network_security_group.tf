resource "azurerm_network_security_group" "network_security_group" {
  for_each = var.nsgs

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}
resource "azurerm_network_security_rule" "network_security_rule" {
  for_each = var.nsg_rules

  name                        = each.value.rulename
  network_security_group_name = azurerm_network_security_group.network_security_group[each.value.nsgname].name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "network_interface_security_group_association" {
  for_each = var.nsg_associations

  network_interface_id      = azurerm_network_interface.network_interface[each.value.name].id
  network_security_group_id = azurerm_network_security_group.network_security_group[each.value.nsgname].id
}