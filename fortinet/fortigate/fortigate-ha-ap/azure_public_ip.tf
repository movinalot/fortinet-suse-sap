resource "azurerm_public_ip" "public_ip" {
  for_each = var.fgt_public_ips

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}
