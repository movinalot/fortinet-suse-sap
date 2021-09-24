resource "azurerm_lb" "lb" {
  for_each = var.lb

  name                = each.value.name
  sku                 = each.value.sku
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  frontend_ip_configuration {
    name                       = each.value.frontend_ip_configuration_name
    subnet_id                  = each.value.frontend_ip_configuration_subnet_id
    private_ip_address_version = each.value.frontend_ip_configuration_private_ip_address_version
    public_ip_address_id       = each.value.frontend_ip_configuration_public_ip_address_id == null ? null : azurerm_public_ip.public_ip[each.value.frontend_ip_configuration_public_ip_address_id].id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  for_each = var.lb_backend_address_pool

  name            = each.value.name
  loadbalancer_id = azurerm_lb.lb[each.value.loadbalancer_id].id
}

resource "azurerm_lb_probe" "lb_probe" {
  for_each = var.lb_probe

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  loadbalancer_id     = azurerm_lb.lb[each.value.loadbalancer_id].id
  port                = each.value.port
  protocol            = each.value.protocol
  interval_in_seconds = each.value.interval_in_seconds
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each = var.lb_rule

  name                           = each.value.name
  resource_group_name            = each.value.resource_group_name
  loadbalancer_id                = azurerm_lb.lb[each.value.loadbalancer_id].id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  probe_id                       = azurerm_lb_probe.lb_probe[each.value.probe_id].id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend_address_pool[each.value.backend_address_pool_id].id
  enable_floating_ip             = each.value.enable_floating_ip
  disable_outbound_snat          = each.value.disable_outbound_snat
}

resource "azurerm_network_interface_backend_address_pool_association" "network_interface_backend_address_pool_association" {
  for_each = var.network_interface_backend_address_pool_association

  network_interface_id    = azurerm_network_interface.network_interface[each.value.network_interface_id].id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool[each.value.backend_address_pool_id].id
}