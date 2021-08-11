module "fortinet-fortiadc-fortiadc-ha-ap" {

  source = "../fortinet/fortiadc/fortiadc-ha-ap"

  resource_group_name     = azurerm_resource_group.resource_group.name
  resource_group_location = azurerm_resource_group.resource_group.location
  subnets                 = azurerm_subnet.subnet
  nsg                     = azurerm_network_security_group.nsg

  lb = {
    "fadc_lb" = {
      name        = "fadc_lb",
      sku         = "standard",
      feip        = "fadc-lb-feip",
      feip_subnet = "security-dmz",
      ip_version  = "IPv4"
    }
  }

  routetables = {
    "fadc_pub_rt"    = { name = "fadc_pub_rt", subnet = "security-dmz" },
    "fadc_priv_rt"   = { name = "fadc_priv_rt", subnet = "shared-services" },
    "fadc_hasync_rt" = { name = "fadc_hasync_rt", subnet = "hasync" },
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
  vm_nics = {
    "fadc_a_nic1" = { name = "port1", subnet = "shared-services", enable_ip_forwarding = true, enable_accelerated_networking = false, ip = "10.160.0.70", ip_config_name = "ipconfig1", ip_config_private_allocation = "static" },
    "fadc_a_nic2" = { name = "port2", subnet = "web", enable_ip_forwarding = true, enable_accelerated_networking = false, ip = "10.160.0.36", ip_config_name = "ipconfig1", ip_config_private_allocation = "static" },
    "fadc_a_nic3" = { name = "port3", subnet = "hasync", enable_ip_forwarding = true, enable_accelerated_networking = false, ip = "10.160.0.102", ip_config_name = "ipconfig1", ip_config_private_allocation = "static" },
    "fadc_b_nic1" = { name = "port1", subnet = "shared-services", enable_ip_forwarding = true, enable_accelerated_networking = false, ip = "10.160.0.71", ip_config_name = "ipconfig1", ip_config_private_allocation = "static" },
    "fadc_b_nic2" = { name = "port2", subnet = "web", enable_ip_forwarding = true, enable_accelerated_networking = false, ip = "10.160.0.37", ip_config_name = "ipconfig1", ip_config_private_allocation = "static" },
    "fadc_b_nic3" = { name = "port3", subnet = "hasync", enable_ip_forwarding = true, enable_accelerated_networking = false, ip = "10.160.0.103", ip_config_name = "ipconfig1", ip_config_private_allocation = "static" }
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
