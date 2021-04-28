resource "azurerm_virtual_network" "virtual_network" {
  for_each            = var.vnets
  name                = each.value["name"]
  address_space       = [each.value["cidr"]]
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  tags = {
    environment = azurerm_resource_group.resource_group.name
  }
}

resource "azurerm_subnet" "hub-subnets" {

  depends_on           = [azurerm_virtual_network.virtual_network["hub-vnet"]]
  for_each             = var.hub-subnets
  name                 = each.value["name"]
  address_prefixes     = [each.value["subnet"]]
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network["hub-vnet"].name
}

resource "azurerm_subnet" "spoke-subnets" {

  depends_on           = [azurerm_virtual_network.virtual_network["spoke-vnet"]]
  for_each             = var.spoke-subnets
  name                 = each.value["name"]
  address_prefixes     = [each.value["subnet"]]
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network["spoke-vnet"].name
}