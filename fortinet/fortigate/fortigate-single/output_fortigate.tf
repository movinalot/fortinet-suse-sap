
output "ResourceGroup" {
  value = var.resource_group_name
}

output "FGTPublicIP" {
  value = "https://${azurerm_public_ip.fgtpublicip.ip_address}"

}

output "Username" {
  value = var.adminusername
}

output "Password" {
  value = var.adminpassword
}