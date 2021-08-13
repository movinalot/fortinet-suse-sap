variable "nsgs" {
  description = "Network Security Groups"
}

variable "vm_configs" {
  description = "vm configurations"
}

variable "fgt_public_ips" {
  description = "vm configurations"
}

variable "routetables" {
  description = "vm configurations"
}

variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "lb_probe" {
  type = string
}
