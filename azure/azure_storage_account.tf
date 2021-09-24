resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_account

  name                     = "${each.value.name}diag${random_id.randomId.hex}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

resource "random_id" "randomId" {
  keepers = {
    resource_group = azurerm_resource_group.resource_group.name
  }

  byte_length = 8
}