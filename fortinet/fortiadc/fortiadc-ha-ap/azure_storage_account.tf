resource "azurerm_storage_account" "example" {
  for_each = var.storage_account

  name                     = format("%s", each.value.name)
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}