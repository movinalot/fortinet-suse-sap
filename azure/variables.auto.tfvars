// Azure Variables

region     = "eastus"
group_name = "jmcdonough-sap"

# VNETs
vnets = {
  hub-vnet = {
    name = "hub-vnet"
    cidr = "10.160.0.0/24"
  }
  spoke-vnet = {
    name = "spoke-vnet"
    cidr = "10.160.1.0/24"
  }
}

# VNET subnets
hub-subnets = {
  security-DMZ = {
    name   = "security-DMZ"
    subnet = "10.160.0.0/27"
  }
  WAF-DMZ = {
    name   = "WAF-DMZ"
    subnet = "10.160.0.32/27"
  }
  shared-services = {
    name   = "shared-services"
    subnet = "10.160.0.64/29"
  }
  monitoring = {
    name   = "monitoring"
    subnet = "10.160.0.72/29"
  }
}

spoke-subnets = {
  netweaver-app-tier = {
    name   = "netweaver-app-tier"
    subnet = "10.160.1.0/26"
  }
  database = {
    name   = "database"
    subnet = "10.160.1.64/27"
  }
  storage = {
    name   = "storage"
    subnet = "10.160.1.96/27"
  }
}