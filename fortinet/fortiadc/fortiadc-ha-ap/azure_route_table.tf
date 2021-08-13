resource "azurerm_route_table" "route_table" {
  for_each = var.route_table

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  for_each = var.subnet_route_table_association

  route_table_id = azurerm_route_table.route_table[each.value.name].id
  subnet_id      = each.value.subnet_id
}

resource "azurerm_route" "route" {
  for_each = var.route

  name                = each.value.name
  route_table_name    = each.value.route_table_name
  resource_group_name = each.value.resource_group_name
  address_prefix      = each.value.address_prefix
  next_hop_type       = each.value.next_hop_type
}