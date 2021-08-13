module "fortinet-fortiadc-fortiadc-ha-ap" {

  count = var.deploy_fadc ? 1 : 0

  source = "../fortinet/fortiadc/fortiadc-ha-ap"

  resource_group_name     = azurerm_resource_group.resource_group.name
  resource_group_location = azurerm_resource_group.resource_group.location
  subnets                 = azurerm_subnet.subnet
  nsg                     = azurerm_network_security_group.nsg

  lb = {
    "fadc_lb" = {
      name                                                 = "fadc_lb",
      sku                                                  = "standard",
      resource_group_name                                  = azurerm_resource_group.resource_group.name,
      location                                             = azurerm_resource_group.resource_group.location
      frontend_ip_configuration_name                       = "fadc-lb-feip",
      frontend_ip_configuration_subnet_id                  = azurerm_subnet.subnet["security-dmz"].id,
      frontend_ip_configuration_private_ip_address_version = "IPv4"
    }
  }

  lb_backend_address_pool = {
    "fadc-lb-be-pool" = {
      name            = "fadc-lb-be-pool"
      loadbalancer_id = "fadc_lb"
    }

  }
  lb_probe = {
    "fadc_lb_probe" = {
      name                = "fadc-lbpool-probe"
      resource_group_name = azurerm_resource_group.resource_group.name
      loadbalancer_id     = "fadc_lb"
      port                = "443"
      protocol            = "Tcp"
      interval_in_seconds = "5"
    }
  }

  lb_rule = {
    "fadc-lbrule" = {
      name                           = "fadc-lbrule"
      resource_group_name            = azurerm_resource_group.resource_group.name
      loadbalancer_id                = "fadc_lb"
      protocol                       = "Tcp"
      frontend_port                  = 443
      backend_port                   = 443
      frontend_ip_configuration_name = "fadc-lb-feip"
      probe_id                       = "fadc_lb_probe"
      backend_address_pool_id        = "fadc-lb-be-pool"
      enable_floating_ip             = false
      disable_outbound_snat          = true
    }
  }

  network_interface_backend_address_pool_association = {
    "fadc_a_nic1" = {
      network_interface_id    = "fadc_a_nic1"
      ip_configuration_name   = "ipconfig1"
      backend_address_pool_id = "fadc-lb-be-pool"
    }

    "fadc_b_nic1" = {
      network_interface_id    = "fadc_b_nic1"
      ip_configuration_name   = "ipconfig1"
      backend_address_pool_id = "fadc-lb-be-pool"
    }
  }

  route_table = {
    "fadc_pub_rt" = {
      name                = "fadc_pub_rt",
      location            = azurerm_resource_group.resource_group.location,
      resource_group_name = azurerm_resource_group.resource_group.name
    },
    "fadc_priv_rt" = {
      name                = "fadc_priv_rt",
      location            = azurerm_resource_group.resource_group.location,
      resource_group_name = azurerm_resource_group.resource_group.name
    },
    "fadc_hasync_rt" = {
      name                = "fadc_hasync_rt",
      location            = azurerm_resource_group.resource_group.location,
      resource_group_name = azurerm_resource_group.resource_group.name
    }
  }

  subnet_route_table_association = {
    "fadc_pub_rt" = {
      name      = "fadc_pub_rt",
      subnet_id = azurerm_subnet.subnet["security-dmz"].id
    },
    "fadc_priv_rt" = {
      name      = "fadc_priv_rt",
      subnet_id = azurerm_subnet.subnet["shared-services"].id
    },
    "fadc_hasync_rt" = {
      name      = "fadc_hasync_rt",
      subnet_id = azurerm_subnet.subnet["hasync"].id
    }
  }

  route = {
    default = {
      name                = "default",
      route_table_name    = "fadc_pub_rt",
      resource_group_name = azurerm_resource_group.resource_group.name,
      address_prefix      = "0.0.0.0/0",
      next_hop_type       = "Internet"
    }
  }


  vm_size            = "Standard_F4s"
  vm_license         = "byol"
  vm_publisher       = "fortinet"
  vm_offer           = "fortinet-fortiadc"
  vm_sku             = "fad-vm-byol"
  vm_version         = "6.1.3"
  vm_bootdiagstorage = "facserial"
  vm_username        = ""
  vm_password        = ""
  network_interface = {
    "fadc_a_nic1" = { name = "port1", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["shared-services"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.70" },
    "fadc_a_nic2" = { name = "port2", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["web"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.36" },
    "fadc_a_nic3" = { name = "port3", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["hasync"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.102" },
    "fadc_b_nic1" = { name = "port1", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["shared-services"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.71" },
    "fadc_b_nic2" = { name = "port2", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["web"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.37" },
    "fadc_b_nic3" = { name = "port3", resource_group_name = azurerm_resource_group.resource_group.name, location = azurerm_resource_group.resource_group.location, enable_ip_forwarding = true, enable_accelerated_networking = false, ip_configuration_name = "ipconfig1", ip_configuration_subnet_id = azurerm_subnet.subnet["hasync"].id, ip_configuration_private_allocation = "static", ip_configuration_private_ip_address = "10.160.0.103" },
  }

  vm_configs = {
    "fadc_a" = {
      "name"     = "fadc-a"
      "identity" = "SystemAssigned"

      "network_interface_ids"        = ["fadc_a_nic1", "fadc_a_nic2", "fadc_a_nic3"],
      "primary_network_interface_id" = "fadc_a_nic1",

      "storage_os_disk_name"              = "fadc_a_OSDisk",
      "storage_os_disk_managed_disk_type" = "Standard_LRS",
      "storage_os_disk_create_option"     = "FromImage",
      "storage_os_disk_caching"           = "ReadWrite",

      "storage_data_disk_name"              = "fadc_a_DataDisk",
      "storage_data_disk_managed_disk_type" = "Premium_LRS"
      "storage_data_disk_create_option"     = "Empty"
      "storage_data_disk_disk_size_gb"      = "30"
      "storage_data_disk_lun"               = 0
      "zone"                                = 1,

      "fadc_license_file" = "FADV040000216490.lic",

      "fadc_config_ha"   = true,
      "fadc_ha_localip"  = "10.160.0.78"
      "fadc_ha_peerip"   = "10.160.0.79"
      "fadc_ha_nodeid"   = "5",
      "fadc_a_ha_nodeid" = "0",
      "fadc_b_ha_nodeid" = "1",
      "fadc_ha_nodeid"   = "0"
    }
    "fadc_b" = {
      "name"     = "fadc-b"
      "identity" = "SystemAssigned"

      "network_interface_ids"        = ["fadc_b_nic1", "fadc_b_nic2", "fadc_b_nic3"],
      "primary_network_interface_id" = "fadc_b_nic1",

      "storage_os_disk_name"              = "fadc_b_OSDisk",
      "storage_os_disk_managed_disk_type" = "Standard_LRS",
      "storage_os_disk_create_option"     = "FromImage",
      "storage_os_disk_caching"           = "ReadWrite",

      "storage_data_disk_name"              = "fadc_b_DataDisk",
      "storage_data_disk_managed_disk_type" = "Premium_LRS"
      "storage_data_disk_create_option"     = "Empty"
      "storage_data_disk_disk_size_gb"      = "30"
      "storage_data_disk_lun"               = 0
      "zone"                                = 2,

      "fadc_license_file" = "FADV040000216491.lic",

      "fadc_config_ha"   = true,
      "fadc_ha_localip"  = "10.160.0.79",
      "fadc_ha_peerip"   = "10.160.0.78",
      "fadc_ha_priority" = "9",
      "fadc_a_ha_nodeid" = "0",
      "fadc_b_ha_nodeid" = "1",
      "fadc_ha_nodeid"   = "1"
    }
  }

}
