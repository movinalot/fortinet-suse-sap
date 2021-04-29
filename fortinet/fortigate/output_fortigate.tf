
output "ResourceGroup" {
  value = var.resource_group_name
}

output "FGTPublicIP" {
  value = azurerm_public_ip.FGTPublicIp.ip_address

}

output "Username" {
  value = var.adminusername
}

output "Password" {
  value = var.adminpassword
}