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

variable "routetables" {
  description = "RouteTable Names"
}

variable "subnets" {
  description = "Subnets"
}

variable "nsg" {
  description = "Network Security Groups"
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
