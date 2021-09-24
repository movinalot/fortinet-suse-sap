variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}

variable "fgt_public_ips" {
  description = "FortiGate Public IPs"
}

variable "network_interfaces" {
  description = "FortiGate Network Interfaces"
}

variable "nsgs" {
  description = "Network Security Groups"
}

variable "nsg_rules" {
  description = "Network Security Group Rules"
}
variable "nsg_associations" {
  description = "Network Security Group association to a nic"
}

variable "subnets" {
  description = "Subnets"
}

variable "fgt_storage_account" {
  description = "Storage Account"
}

variable "lb" {
  description = "Load Balancer"
}

variable "lb_backend_address_pool" {
  description = "Load Balancer"
}

variable "lb_probe" {
  description = "Load Balancer"
}

variable "lb_rule" {
  description = "Load Balancer"
}

variable "network_interface_backend_address_pool_association" {
  description = "Load Balancer"
}
