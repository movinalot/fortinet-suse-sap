resource "azurerm_network_interface" "fadc_nic" {
  for_each = var.vm_nics

  name                          = each.key
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  enable_accelerated_networking = each.value.enable_accelerated_networking

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = var.subnets[each.value.subnet].id
    private_ip_address_allocation = each.value.ip_config_private_allocation
    private_ip_address            = each.value.ip
  }
}