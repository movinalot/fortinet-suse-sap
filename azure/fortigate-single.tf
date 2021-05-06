module "fortiadc-single" {

  source = "../fortinet/fortiadc-single"

  resource_group_name               = azurerm_resource_group.resource_group.name
  resource_group_location           = azurerm_resource_group.resource_group.location
  hub_security_dmz_subnet_id        = azurerm_subnet.hub-subnets["security-dmz"].id
  hub_waf_dmz_subnet_id             = azurerm_subnet.hub-subnets["waf-dmz"].id
  hub_shared_services_subnet_id     = azurerm_subnet.hub-subnets["shared-services"].id
  route_table_id                    = azurerm_route_table.internal.id
  route_table_name                  = azurerm_route_table.internal.name
  public_network_security_group_id  = azurerm_network_security_group.publicnetworknsg.id
  private_network_security_group_id = azurerm_network_security_group.publicnetworknsg.id
}
