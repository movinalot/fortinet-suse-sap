module "fortiadc-fortiadc-ha-ap" {

  source = "../fortinet/fortiadc/fortiadc-ha-ap"

  resource_group_name     = azurerm_resource_group.resource_group.name
  resource_group_location = azurerm_resource_group.resource_group.location
  subnets                 = azurerm_subnet.subnets
  nsg                     = azurerm_network_security_group.nsg

  routetables = {
    "fadc_pub_rt"    = { name = "fadc_pub_rt", subnet = "security-dmz" },
    "fadc_priv_rt"   = { name = "fadc_priv_rt", subnet = "shared-services" },
    "fadc_hasync_rt" = { name = "fadc_hasync_rt", subnet = "hasync" },
  }

  fadc1 = {
    "nic1" = {vmname="fadc1", name="port1", subnet="security-dmz", ip="10.160.0.6"},
    "nic2" = {vmname="fadc1", name="port2", subnet="shared-services", ip="10.160.0.68"},
    "nic3" = {vmname="fadc1", name="port3", subnet="hasync", ip="10.160.0.76"}
  }
  fadc2 = {
    "nic1" = {vmname="fadc2", name="port1", subnet="security-dmz", ip="10.160.0.7"},
    "nic2" = {vmname="fadc2", name="port2", subnet="shared-services", ip="10.160.0.69"},
    "nic3" = {vmname="fadc2", name="port3", subnet="hasync", ip="10.160.0.77"}
  }
}
