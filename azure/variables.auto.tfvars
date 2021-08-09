// Azure Variables

region     = "eastus"
group_name = "jmcdonough-sap"

# VNET
vnets = {
  "hub-vnet" = { name = "hub-vnet", cidr = "10.160.0.0/24" }
}

# VNET subnets
subnets = {
  "security-dmz"    = { name = "security-dmz", vnet-name = "hub-vnet", subnet = "10.160.0.0/27" }
  "waf"             = { name = "waf", vnet-name = "hub-vnet", subnet = "10.160.0.32/27" }
  "shared-services" = { name = "shared-services", vnet-name = "hub-vnet", subnet = "10.160.0.64/29" }
  "hasync"          = { name = "hasync", vnet-name = "hub-vnet", subnet = "10.160.0.72/29" }
  "mgmt"            = { name = "mgmt", vnet-name = "hub-vnet", subnet = "10.160.0.80/29" }
}

nsgs = {
  "PublicNetworkSecurityGroup"  = { name = "PublicNetworkSecurityGroup" },
  "PrivateNetworkSecurityGroup" = { name = "PrivateNetworkSecurityGroup" }
}

nsgrules = {
  "PublicNetworkSecurityGroup"  = { nsgname = "PublicNetworkSecurityGroup", rulename = "TCP", priority = "1001", direction = "Inbound", access = "Allow", protocol = "Tcp" },
  "PublicNetworkSecurityGroup"  = { nsgname = "PublicNetworkSecurityGroup", rulename = "egress", priority = "100", direction = "Outbound", access = "Allow", protocol = "*" },
  "PrivateNetworkSecurityGroup" = { nsgname = "PrivateNetworkSecurityGroup", rulename = "All", priority = "1001", direction = "Inbound", access = "Allow", protocol = "*" },
  "PrivateNetworkSecurityGroup" = { nsgname = "PrivateNetworkSecurityGroup", rulename = "egress-provate", priority = "100", direction = "Outbound", access = "Allow", protocol = "*" }
}

