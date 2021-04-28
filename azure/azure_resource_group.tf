resource "azurerm_resource_group" "resource_group" {
  name     = var.group_name
  location = var.region

  tags = {
    environment = var.group_name
    username    = "jmcdonough"
  }
}