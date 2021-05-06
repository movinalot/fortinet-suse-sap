resource "random_id" "randomId" {
  keepers = {
    resource_group = var.resource_group_name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "fadcstorageaccount" {
  name                     = "fadcdiag${random_id.randomId.hex}"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    environment = var.resource_group_name
  }
}
