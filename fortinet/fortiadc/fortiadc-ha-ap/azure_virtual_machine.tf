resource "azurerm_virtual_machine" "fadc" {
  for_each                     = var.vm_configs
  name                         = each.value.name
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  network_interface_ids        = [for nic in each.value.network_interface_ids : azurerm_network_interface.network_interface[nic].id]
  primary_network_interface_id = azurerm_network_interface.network_interface[each.value.primary_network_interface_id].id
  vm_size                      = var.vm_size

  identity {
    type = each.value.identity
  }

  storage_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  plan {
    publisher = var.vm_publisher
    product   = var.vm_offer
    name      = var.vm_sku
  }

  storage_os_disk {
    name              = each.value.storage_os_disk_name
    managed_disk_type = each.value.storage_os_disk_managed_disk_type
    create_option     = each.value.storage_os_disk_create_option
    caching           = each.value.storage_os_disk_caching
  }

  storage_data_disk {
    name              = each.value.storage_data_disk_name
    managed_disk_type = each.value.storage_data_disk_managed_disk_type
    create_option     = each.value.storage_data_disk_create_option
    disk_size_gb      = each.value.storage_data_disk_disk_size_gb
    lun               = each.value.storage_data_disk_lun
  }
  os_profile {
    computer_name  = each.value.name
    admin_username = var.vm_username
    admin_password = var.vm_password
    custom_data    = data.template_file.fadc_customdata[each.key].rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  zones = [each.value.zone]
}
data "template_file" "fadc_customdata" {
  for_each = var.vm_configs
  template = file("../fortinet/fortiadc/fortiadc-ha-ap/assets/fadc-userdata.tpl")
  vars = {
    fadc_id           = each.value.name
    fadc_license_file = "../fortinet/fortiadc/fortiadc-ha-ap/${each.value.fadc_license_file}"
    fadc_config_ha    = true

    fadc_ha_localip  = each.value.fadc_ha_localip
    fadc_ha_peerip   = each.value.fadc_ha_peerip
    fadc_ha_priority = each.value.fadc_ha_nodeid
    fadc_a_ha_nodeid = each.value.fadc_a_ha_nodeid
    fadc_b_ha_nodeid = each.value.fadc_b_ha_nodeid
    fadc_ha_nodeid   = each.value.fadc_ha_nodeid
  }
}