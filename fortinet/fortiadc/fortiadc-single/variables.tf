variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "hub_waf_dmz_subnet_id" {
  type = string
}
variable "hub_security_dmz_subnet_id" {
  type = string
}
variable "hub_shared_services_subnet_id" {
  type = string
}
variable "route_table_id" {
  type = string
}
variable "route_table_name" {
  type = string
}
variable "private_network_security_group_id" {
  type = string
}
variable "public_network_security_group_id" {
  type = string
}

variable "size" {
  type    = string
  default = "Standard_F4s"
}

// FortiGate License Type
// Either byol or payg.
variable "license_type" {
  default = "byol"
}

variable "publisher" {
  type    = string
  default = "fortinet"
}

variable "fadcoffer" {
  type    = string
  default = "fortinet-fortiadc"
}

variable "fadcsku" {
  type = string
  default = "fad-vm-byol"
}

variable "fadcversion" {
  type    = string
  default = "6.1.2"
}

variable "adminusername" {
  type    = string
  default = "azureadmin"
}

variable "" {
  type    = string
  default = ""
}

variable "license" {
  type    = string
  default = "../fortinet/fortiadc-single/FADV040000216450.lic"
}