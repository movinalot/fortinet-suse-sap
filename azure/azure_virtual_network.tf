resource "azurerm_virtual_network" "virtual_network" {
  for_each = var.vnets

  name                = each.value["name"]
  address_space       = [each.value["cidr"]]
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  tags = {
    environment = azurerm_resource_group.resource_group.name
  }
}

resource "azurerm_subnet" "subnets" {

  depends_on = [azurerm_virtual_network.virtual_network]

  for_each             = var.subnets
  name                 = each.value["name"]
  address_prefixes     = [each.value["subnet"]]
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network[each.value["vnet-name"]].name
}
