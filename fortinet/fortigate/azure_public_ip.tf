resource "azurerm_public_ip" "FGTPublicIp" {
  name                = "FGTPublicIP"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"

  tags = {
    environment = var.resource_group_name
  }
}