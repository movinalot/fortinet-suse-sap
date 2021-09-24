module "fortinet-fortigate-fortigate-ha-ap" {

  count = var.deploy_fgt ? 1 : 0

  source = "../fortinet/fortigate/fortigate-ha-ap"

  resource_group_name     = azurerm_resource_group.resource_group.name
  resource_group_location = azurerm_resource_group.resource_group.location
  subnets                 = azurerm_subnet.subnet
  fgt_storage_account     = azurerm_storage_account.storage_account["fgt_storage_account"]

  lb = {
    "fgt_external_lb" = {
      name                                                 = "fgt_external_lb",
      sku                                                  = "standard",
      resource_group_name                                  = azurerm_resource_group.resource_group.name,
      location                                             = azurerm_resource_group.resource_group.location
      frontend_ip_configuration_name                       = "fgt-external-lb-feip"
      frontend_ip_configuration_subnet_id                  = null
      frontend_ip_configuration_private_ip_address_version = null
      frontend_ip_configuration_public_ip_address_id       = "fgt_a_pub_ip"
    },
    "fgt_internal_lb" = {
      name                                                 = "fgt_internal_lb",
      sku                                                  = "standard",
      resource_group_name                                  = azurerm_resource_group.resource_group.name,
      location                                             = azurerm_resource_group.resource_group.location
      frontend_ip_configuration_name                       = "fgt-internal-lb-feip"
      frontend_ip_configuration_subnet_id                  = azurerm_subnet.subnet["shared-services"].id
      frontend_ip_configuration_private_ip_address_version = "IPv4"
      frontend_ip_configuration_public_ip_address_id       = null
    }
  }

  lb_backend_address_pool = {
    "fgt-external-lb-be-pool" = {
      name            = "fgt-external-lb-be-pool"
      loadbalancer_id = "fgt_external_lb"
    },
      "fgt-internal-lb-be-pool" = {
      name            = "fgt-internal-lb-be-pool"
      loadbalancer_id = "fgt_internal_lb"
    },
  }

  lb_probe = {
    "fgt_external_lb_probe" = {
      name                = "fgt-lbpool-probe"
      resource_group_name = azurerm_resource_group.resource_group.name
      loadbalancer_id     = "fgt_external_lb"
      port                = "8008"
      protocol            = "Tcp"
      interval_in_seconds = "5"
    },
    "fgt_internal_lb_probe" = {
      name                = "fgt-lbpool-probe"
      resource_group_name = azurerm_resource_group.resource_group.name
      loadbalancer_id     = "fgt_internal_lb"
      port                = "8008"
      protocol            = "Tcp"
      interval_in_seconds = "5"
    }
  }

  lb_rule = {
    "fgt-external-lbrule" = {
      name                           = "fgt-extrenal-lbrule"
      resource_group_name            = azurerm_resource_group.resource_group.name
      loadbalancer_id                = "fgt_external_lb"
      protocol                       = "Tcp"
      frontend_port                  = 443
      backend_port                   = 443
      frontend_ip_configuration_name = "fgt-external-lb-feip"
      probe_id                       = "fgt_external_lb_probe"
      backend_address_pool_id        = "fgt-external-lb-be-pool"
      enable_floating_ip             = false
      disable_outbound_snat          = true
    }
  }

  network_interface_backend_address_pool_association = {
    "fgt_a_nic1" = {
      network_interface_id    = "fgt_a_nic1"
      ip_configuration_name   = "ipconfig1"
      backend_address_pool_id = "fgt-external-lb-be-pool"
    },
    "fgt_b_nic1" = {
      network_interface_id    = "fgt_b_nic1"
      ip_configuration_name   = "ipconfig1"
      backend_address_pool_id = "fgt-external-lb-be-pool"
    },
    "fgt_a_nic2" = {
      network_interface_id    = "fgt_a_nic1"
      ip_configuration_name   = "ipconfig1"
      backend_address_pool_id = "fgt-internal-lb-be-pool"
    },
    "fgt_b_nic2" = {
      network_interface_id    = "fgt_b_nic1"
      ip_configuration_name   = "ipconfig1"
      backend_address_pool_id = "fgt-internal-lb-be-pool"
    }
  }

  fgt_public_ips = {
    "fgt_a_pub_ip" = { name = "fgt_a_pub_ip", allocation_method = "Static", sku = "Standard"},
    "fgt_b_pub_ip" = { name = "fgt_b_pub_ip", allocation_method = "Static", sku = "Standard"},
    "fgt_c_pub_ip" = { name = "fgt_c_pub_ip", allocation_method = "Static", sku = "Standard"}
  }

  network_interfaces = {
    "fgt_a_nic1" = { name = "port1", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["security-dmz"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.4", nsgname = "public_nsg_group" },
    "fgt_a_nic2" = { name = "port2", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["shared-services"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.70", nsgname = "private_nsg_group" },
    "fgt_a_nic3" = { name = "port3", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["hasync"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.100", nsgname = "private_nsg_group" },
    "fgt_a_nic4" = { name = "port4", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["mgmt"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.132", nsgname = "public_nsg_group" },

    "fgt_b_nic1" = { name = "port1", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["security-dmz"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.5", nsgname = "public_nsg_group" },
    "fgt_b_nic2" = { name = "port2", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["shared-services"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.71", nsgname = "private_nsg_group" },
    "fgt_b_nic3" = { name = "port3", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["hasync"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.101", nsgname = "private_nsg_group" },
    "fgt_b_nic4" = { name = "port4", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["mgmt"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.133", nsgname = "public_nsg_group" },

  }
  nsgs = {
    "public_nsg_group"  = { name = "public_nsg_group" },
    "private_nsg_group" = { name = "private_nsg_group" }
  }

  nsg_rules = {
    "public_nsg_inbound_rule" = {
      nsgname                    = "public_nsg_group",
      rulename                   = "TCP",
      priority                   = "1001",
      direction                  = "Inbound",
      access                     = "Allow",
      protocol                   = "Tcp",
      source_port_range          = "*",
      destination_port_range     = "*",
      source_address_prefix      = "*",
      destination_address_prefix = "*"
    },
    "private_nsg_inbound_rule" = {
      nsgname                    = "private_nsg_group",
      rulename                   = "All",
      priority                   = "1001",
      direction                  = "Inbound",
      access                     = "Allow",
      protocol                   = "*",
      source_port_range          = "*",
      destination_port_range     = "*",
      source_address_prefix      = "*",
      destination_address_prefix = "*"
    }
    "public_nsg_outbound_rule" = {
      nsgname                    = "public_nsg_group",
      rulename                   = "egress-public",
      priority                   = "1001",
      direction                  = "Outbound",
      access                     = "Allow",
      protocol                   = "*",
      source_port_range          = "*",
      destination_port_range     = "*",
      source_address_prefix      = "*",
      destination_address_prefix = "*"
    },
    "private_nsg_inbound_rule" = {
      nsgname                    = "private_nsg_group",
      rulename                   = "egress-private",
      priority                   = "1001",
      direction                  = "Outbound",
      access                     = "Allow",
      protocol                   = "*",
      source_port_range          = "*",
      destination_port_range     = "*",
      source_address_prefix      = "*",
      destination_address_prefix = "*"
    }
  }

  nsg_associations = {
    "fgt_a_nic1" = { name = "fgt_a_nic1", nsgname = "public_nsg_group" },
    "fgt_a_nic2" = { name = "fgt_a_nic2", nsgname = "private_nsg_group" },
    "fgt_a_nic3" = { name = "fgt_a_nic3", nsgname = "private_nsg_group" },
    "fgt_a_nic4" = { name = "fgt_a_nic4", nsgname = "public_nsg_group" },

    "fgt_b_nic1" = { name = "fgt_b_nic1", nsgname = "public_nsg_group" },
    "fgt_b_nic2" = { name = "fgt_b_nic2", nsgname = "private_nsg_group" },
    "fgt_b_nic3" = { name = "fgt_b_nic3", nsgname = "private_nsg_group" },
    "fgt_b_nic4" = { name = "fgt_b_nic4", nsgname = "public_nsg_group" },
  }
}