resource "azurerm_virtual_network_peering" "hub-vnet" {
  name                         = format("%s_to_%s", azurerm_virtual_network.virtual_network["hub-vnet"].name, azurerm_virtual_network.virtual_network["spoke-vnet"].name)
  resource_group_name          = var.group_name
  virtual_network_name         = azurerm_virtual_network.virtual_network["hub-vnet"].name
  remote_virtual_network_id    = azurerm_virtual_network.virtual_network["spoke-vnet"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke-vnet" {
  name                         = format("%s_to_%s", azurerm_virtual_network.virtual_network["spoke-vnet"].name, azurerm_virtual_network.virtual_network["hub-vnet"].name)
  resource_group_name          = var.group_name
  virtual_network_name         = azurerm_virtual_network.virtual_network["spoke-vnet"].name
  remote_virtual_network_id    = azurerm_virtual_network.virtual_network["hub-vnet"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}