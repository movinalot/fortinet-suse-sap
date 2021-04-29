
# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  depends_on                = [azurerm_network_interface.fgtport1]
  network_interface_id      = azurerm_network_interface.fgtport1.id
  network_security_group_id = var.public_network_security_group_id
}

resource "azurerm_network_interface_security_group_association" "port2nsg" {
  depends_on                = [azurerm_network_interface.fgtport2]
  network_interface_id      = azurerm_network_interface.fgtport2.id
  network_security_group_id = var.private_network_security_group_id
}