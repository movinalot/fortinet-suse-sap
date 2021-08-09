resource "azurerm_route_table" "route_table" {
  for_each = var.routetables

  name                = each.value.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  for_each = var.routetables

  route_table_id = azurerm_route_table.route_table["${each.value.name}"].id
  subnet_id      = var.subnets["${each.value.subnet}"].id
}

#resource "azurerm_route" "default" {
#  name                   = "default"
#  resource_group_name    = var.resource_group_name
#  route_table_name       = var.route_table_name
#  address_prefix         = "0.0.0.0/0"
#  next_hop_type          = "VirtualAppliance"
#  next_hop_in_ip_address = azurerm_network_interface.fadport2.private_ip_address
#}