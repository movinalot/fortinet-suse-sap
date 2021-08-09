resource "azurerm_virtual_machine" "fadc1" {
  name                         = "fadc1"
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  network_interface_ids        = [for nic in azurerm_network_interface.fadc1nics : nic.id]
  primary_network_interface_id = azurerm_network_interface.fadc1nics["nic1"].id
  vm_size                      = var.fadc_vmsize

  identity {
    type = "SystemAssigned"
  }

  storage_image_reference {
    publisher = var.fadc_PUBLISHER
    offer     = var.fadc_OFFER
    sku       = var.fadc_IMAGE_SKU
    version   = var.fadc_VERSION
  }

  plan {
    publisher = var.fadc_PUBLISHER
    product   = var.fadc_OFFER
    name      = var.fadc_IMAGE_SKU
  }

  storage_os_disk {
    name              = "fadc1_OSDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "fadc1_DataDisk"
    managed_disk_type = "Premium_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }
  os_profile {
    computer_name  = "fadc1"
    admin_username = var.username
    admin_password = var.password
    custom_data    = data.template_file.fadc1_customdata.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  zones = [1]
}

resource "azurerm_virtual_machine" "fadc2" {
  name                         = "fadc2"
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  network_interface_ids        = [for nic in azurerm_network_interface.fadc2nics : nic.id]
  primary_network_interface_id = azurerm_network_interface.fadc2nics["nic1"].id
  vm_size                      = var.fadc_vmsize

  identity {
    type = "SystemAssigned"
  }

  storage_image_reference {
    publisher = var.fadc_PUBLISHER
    offer     = var.fadc_OFFER
    sku       = var.fadc_IMAGE_SKU
    version   = var.fadc_VERSION
  }

  plan {
    publisher = var.fadc_PUBLISHER
    product   = var.fadc_OFFER
    name      = var.fadc_IMAGE_SKU
  }

  storage_os_disk {
    name              = "fadc2_OSDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "fadc2_DataDisk"
    managed_disk_type = "Premium_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }
  os_profile {
    computer_name  = "fadc2"
    admin_username = var.username
    admin_password = var.password
    custom_data    = data.template_file.fadc2_customdata.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  zones = [2]
}
data "template_file" "fadc1_customdata" {
  template = file ("../fortinet/fortiadc/fortiadc-ha-ap/assets/fadc-userdata.tpl")
  vars = {
    fadc_id              = element ( values(var.fadc1)[*].vmname , 0)
    fadc_license_file    = "../fortinet/fortiadc/fortiadc-ha-ap/FADV040000216490.lic"
    fadc_config_ha       = true

    fadc_ha_localip      = element ( values(var.fadc1)[*].ip , 2)
    fadc_ha_peerip       = element ( values(var.fadc2)[*].ip , 2)
    fadc_ha_priority     = "5"
    fadc1_ha_nodeid      = "0"
    fadc2_ha_nodeid      = "1"
    fadc_ha_nodeid       = "0"

  }
}

data "template_file" "fadc2_customdata" {
  template = file ("../fortinet/fortiadc/fortiadc-ha-ap/assets/fadc-userdata.tpl")
  vars = {
    fadc_id              = element ( values(var.fadc1)[*].vmname , 0)
    fadc_license_file    = "../fortinet/fortiadc/fortiadc-ha-ap/FADV040000216491.lic"
    fadc_config_ha       = true

    fadc_ha_localip      = element ( values(var.fadc2)[*].ip , 2)
    fadc_ha_peerip       = element ( values(var.fadc1)[*].ip , 2)
    fadc_ha_priority     = "9"
    fadc1_ha_nodeid      = "0"
    fadc2_ha_nodeid      = "1"
    fadc_ha_nodeid       = "1"    

  }
}