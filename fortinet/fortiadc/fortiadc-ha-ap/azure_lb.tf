resource "azurerm_lb" "ilb" {

  name                = "fadc-ilb"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                       = "fadc-ilb-feip"
    subnet_id                  = var.subnets["security-dmz"].id
    private_ip_address_version = "IPv4"
  }
}

resource "azurerm_lb_backend_address_pool" "ilb_backend" {
  name            = "fadc-ilb-be-pool"
  loadbalancer_id = azurerm_lb.ilb.id
}

resource "azurerm_lb_probe" "ilb_probe" {
  name                = "fadc-ilbpool-probe"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.ilb.id
  port                = "443"
  protocol            = "Tcp"
  interval_in_seconds = "5"
}

resource "azurerm_lb_rule" "ilb_rule_tcp443" {
  name                           = "fadc-ilbrule"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.ilb.id
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "fadc-ilb-feip"
  probe_id                       = azurerm_lb_probe.ilb_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.ilb_backend.id
  enable_floating_ip             = false
  disable_outbound_snat          = true
}

resource "azurerm_network_interface_backend_address_pool_association" "ilb_backend_assoc_fadc1" {
  network_interface_id    = azurerm_network_interface.fadc1nics["nic1"].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ilb_backend.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ilb_backend_assoc_fadc2" {
  network_interface_id    = azurerm_network_interface.fadc2nics["nic1"].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ilb_backend.id
}