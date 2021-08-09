// FGT Network Interface port1
resource "azurerm_network_interface" "fadcport1" {
  name                 = "fadcport1"
  resource_group_name  = var.resource_group_name
  location             = var.resource_group_location
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.hub_waf_dmz_subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.fadcpublicip.id
  }

  tags = {
    environment = var.resource_group_name
  }
}

resource "azurerm_network_interface" "fadcport2" {
  name                 = "fadcport2"
  resource_group_name  = var.resource_group_name
  location             = var.resource_group_location
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.hub_shared_services_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = var.resource_group_name
  }
}
