resource "azurerm_virtual_machine" "fadc" {
  name                         = "FADC"
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  network_interface_ids        = [azurerm_network_interface.fadcport1.id, azurerm_network_interface.fadcport2.id]
  primary_network_interface_id = azurerm_network_interface.fadcport1.id
  vm_size                      = var.size
  storage_image_reference {
    publisher = var.publisher
    offer     = var.fadcoffer
    sku       = var.fadcsku
    version   = var.fadcversion
  }

  plan {
    name      = var.fadcsku
    publisher = var.publisher
    product   = var.fadcoffer
  }

  storage_os_disk {
    name              = "fadcosDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Log data disks
  storage_data_disk {
    name              = "fadcvmdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }

  os_profile {
    computer_name  = "fadc"
    admin_username = var.adminusername
    admin_password = var.adminpassword
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fadcstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = var.resource_group_name
  }
}
