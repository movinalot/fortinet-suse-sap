
resource "azurerm_route" "default" {
  name                   = "default"
  resource_group_name    = var.resource_group_name
  route_table_name       = var.route_table_name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.fgtport2.private_ip_address
}

resource "azurerm_subnet_route_table_association" "internalassociate" {
  subnet_id      = var.hub_shared_services_subnet_id
  route_table_id = var.route_table_id
}