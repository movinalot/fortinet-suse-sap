// Azure Variables

region     = "eastus"
group_name = "jmcdonough-sap"

vnets = {
  "hub" = {
    name = "hub",
    cidr = "10.160.0.0/24"
  }
}

subnets = {
  "security-dmz" = {
    name   = "security-dmz",
    vnet   = "hub",
    subnet = "10.160.0.0/27"
  },
  "web" = {
    name   = "web",
    vnet   = "hub",
    subnet = "10.160.0.32/27"
  }
  "shared-services" = {
    name   = "shared-services",
    vnet   = "hub",
    subnet = "10.160.0.64/27"
  }
  "hasync" = {
    name   = "hasync",
    vnet   = "hub",
    subnet = "10.160.0.96/27"
  }
  "mgmt" = {
    name   = "mgmt",
    vnet   = "hub",
    subnet = "10.160.0.128/27"
  }
}

nsgs = {
  "PublicNetworkSecurityGroup"  = { name = "PublicNetworkSecurityGroup" },
  "PrivateNetworkSecurityGroup" = { name = "PrivateNetworkSecurityGroup" }
}

nsgrules = {
  "PublicNetworkSecurityGroup" = {
    nsgname                    = "PublicNetworkSecurityGroup",
    rulename                   = "TCP",
    priority                   = "1001",
    direction                  = "Inbound",
    access                     = "Allow",
    protocol                   = "Tcp",
    source_port_range          = "*",
    destination_port_range     = "*",
    source_address_prefix      = "*",
    destination_address_prefix = "*"
  },
  "PublicNetworkSecurityGroup" = {
    nsgname                    = "PublicNetworkSecurityGroup",
    rulename                   = "egress",
    priority                   = "100",
    direction                  = "Outbound",
    access                     = "Allow",
    protocol                   = "*",
    source_port_range          = "*",
    destination_port_range     = "*",
    source_address_prefix      = "*",
    destination_address_prefix = "*"
  },
  "PrivateNetworkSecurityGroup" = {
    nsgname                    = "PrivateNetworkSecurityGroup",
    rulename                   = "All",
    priority                   = "1001",
    direction                  = "Inbound",
    access                     = "Allow",
    protocol                   = "*",
    source_port_range          = "*",
    destination_port_range     = "*",
    source_address_prefix      = "*",
    destination_address_prefix = "*"
  },
  "PrivateNetworkSecurityGroup" = {
    nsgname                    = "PrivateNetworkSecurityGroup",
    rulename                   = "egress-private",
    priority                   = "100",
    direction                  = "Outbound",
    access                     = "Allow",
    protocol                   = "*",
    source_port_range          = "*",
    destination_port_range     = "*",
    source_address_prefix      = "*",
    destination_address_prefix = "*"
  }
}

