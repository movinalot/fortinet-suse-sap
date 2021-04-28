resource "azurerm_route_table" "internal" {
  name                = "RouteTable"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}
