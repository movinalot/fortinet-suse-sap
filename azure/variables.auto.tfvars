region     = "eastus"
group_name = "jmcdonough-sap"

deploy_fadc = "true"
deploy_fgt  = "true"

vnets = {
  "hub" = { name = "hub", cidr = "10.160.0.0/24" }
}

subnets = {
  "security-dmz"    = { name = "security-dmz", vnet = "hub", subnet = "10.160.0.0/27" },
  "web"             = { name = "web", vnet = "hub", subnet = "10.160.0.32/27" },
  "shared-services" = { name = "shared-services", vnet = "hub", subnet = "10.160.0.64/27" },
  "hasync"          = { name = "hasync", vnet = "hub", subnet = "10.160.0.96/27" },
  "mgmt"            = { name = "mgmt", vnet = "hub", subnet = "10.160.0.128/27" }
}

storage_account = {
  "fadc_storage_account" = { name = "fadc", account_tier = "Standard", account_replication_type = "LRS" },
  "fgt_storage_account" = { name = "fgt", account_tier = "Standard", account_replication_type = "LRS" }
}
route_tables = {
  "public_rt"  = { name = "public_rt", location = "eastus" },
  "private_rt" = { name = "private_rt", location = "eastus" },
  "hasync_rt"  = { name = "hasync_rt", location = "eastus" }
}
subnet_route_table_associations = {
  "public_rt"  = { name = "public_rt", subnet_id = "security-dmz" },
  "private_rt" = { name = "private_rt", subnet_id = "shared-services" },
  "hasync_rt"  = { name = "hasync_rt", subnet_id = "hasync" }
}
routes = {
  default_to_fortigate = {
    name                   = "default_to_fortigate",
    route_table_name       = "private_rt",
    address_prefix         = "0.0.0.0/0",
    next_hop_type          = "VirtualAppliance",
    next_hop_in_ip_address = "10.160.0.68"
  },
  #  default_to_fortiadc = {
  #    name                   = "default_to_fortiadc",
  #    route_table_name       = "private_rt",
  #    address_prefix         = "0.0.0.0/0",
  #    next_hop_type          = "VirtualAppliance",
  #    next_hop_in_ip_address = "10.160.0.68"
  #  },
  default_to_internet = {
    name                   = "default_to_internet",
    route_table_name       = "public_rt",
    address_prefix         = "0.0.0.0/0",
    next_hop_type          = "Internet",
    next_hop_in_ip_address = null
  }
}

