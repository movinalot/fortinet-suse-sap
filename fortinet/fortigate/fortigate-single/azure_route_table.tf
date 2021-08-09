resource "azurerm_route_table" "internal" {
  name                = var.routetable
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}
