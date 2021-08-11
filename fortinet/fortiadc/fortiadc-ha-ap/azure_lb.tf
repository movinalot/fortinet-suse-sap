resource "azurerm_lb" "lb" {
  for_each = var.lb

  name                = each.value.name
  sku                 = each.value.sku
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  frontend_ip_configuration {
    name                       = each.value.feip
    subnet_id                  = var.subnets[each.value.feip_subnet].id
    private_ip_address_version = each.value.ip_version
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name            = "fadc-lb-be-pool"
  loadbalancer_id = azurerm_lb.lb["fadc_lb"].id
}

resource "azurerm_lb_probe" "lb_probe" {
  name                = "fadc-lbpool-probe"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb["fadc_lb"].id
  port                = "443"
  protocol            = "Tcp"
  interval_in_seconds = "5"
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "fadc-lbrule"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb["fadc_lb"].id
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "fadc-lb-feip"
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
  enable_floating_ip             = false
  disable_outbound_snat          = true
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_assoc_fadc_a" {
  network_interface_id    = azurerm_network_interface.fadc_nic["fadc_a_nic1"].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_assoc_fadc_b" {
  network_interface_id    = azurerm_network_interface.fadc_nic["fadc_b_nic1"].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
}