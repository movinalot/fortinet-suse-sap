variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_license" {
  type = string
}

variable "vm_publisher" {
  type = string
}

variable "vm_offer" {
  type = string
}

variable "vm_sku" {
  type = string
}

variable "vm_version" {
  type = string
}

variable "route_tables" {
  description = "RouteTable Names"
}

variable "fadc_storage_account" {
  description = "Storage Account"
}

variable "subnets" {
  description = "Subnets"
}

variable "lb" {
  description = "Load Balancers"
}

variable "vm_bootdiagstorage" {
  type = string
}

variable "vm_configs" {
  description = "vm configurations"
}

variable "network_interfaces" {
  description = "network interface configurations"
}

variable "vm_username" {
  type        = string
  description = "Username"
}

variable "vm_password" {
  type        = string
  description = "Password"
}

variable "lb_probe" {
  description = "lb settings"
}

variable "lb_backend_address_pool" {
  description = "lb settings"
}

variable "lb_rule" {
  description = "lb settings"
}

variable "network_interface_backend_address_pool_association" {
  description = "lb settings"
}

variable "subnet_route_table_associations" {
  description = "Subnet route table association"
}

variable "routes" {
  description = "Subnet route table association"
}