resource "azurerm_network_interface" "fadc1nics" {
  for_each = var.fadc1

  name                          = "${each.value.vmname}-${each.value.name}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  enable_ip_forwarding          = true
  enable_accelerated_networking = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnets["${each.value.subnet}"].id
    private_ip_address_allocation = "static"
    private_ip_address            = each.value.ip
  }
}

resource "azurerm_network_interface" "fadc2nics" {
  for_each = var.fadc2

  name                          = "${each.value.vmname}-${each.value.name}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  enable_ip_forwarding          = true
  enable_accelerated_networking = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnets["${each.value.subnet}"].id
    private_ip_address_allocation = "static"
    private_ip_address            = each.value.ip
  }
}