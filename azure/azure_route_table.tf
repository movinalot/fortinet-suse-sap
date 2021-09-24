resource "azurerm_route_table" "route_table" {
  for_each = var.route_tables

  name                = each.value.name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

resource "azurerm_route" "route" {
  for_each = var.routes

  name                   = each.value.name
  route_table_name       = azurerm_route_table.route_table[each.value.route_table_name].name
  resource_group_name    = azurerm_resource_group.resource_group.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  for_each = var.subnet_route_table_associations

  route_table_id = azurerm_route_table.route_table[each.value.name].id
  subnet_id      = azurerm_subnet.subnet[each.value.subnet_id].id
}