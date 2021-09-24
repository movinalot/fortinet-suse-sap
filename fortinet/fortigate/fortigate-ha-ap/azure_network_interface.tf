resource "azurerm_network_interface" "network_interface" {
  for_each = var.network_interfaces

  name                          = each.key
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  enable_accelerated_networking = each.value.enable_accelerated_networking

  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = each.value.ip_configuration_subnet_id
    private_ip_address_allocation = each.value.ip_configuration_private_allocation
    private_ip_address            = each.value.ip_configuration_private_ip_address
  }
}