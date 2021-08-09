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
  default = "Standard_F4"
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

variable "fgtoffer" {
  type    = string
  default = "fortinet_fortigate-vm_v5"
}

// BYOL sku: fortinet_fg-vm
// PAYG sku: fortinet_fg-vm_payg_20190624
variable "fgtsku" {
  type = map(any)
  default = {
    byol = "fortinet_fg-vm"
    payg = "fortinet_fg-vm_payg_20190624"
  }
}

variable "fgtversion" {
  type    = string
  default = "7.0.0"
}

variable "adminusername" {
  type    = string
  default = "azureadmin"
}

variable "adminpassword" {
  type    = string
  default = "123Password#@!"
}

variable "bootstrap-fgt" {
  type    = string
  default = "../fortinet/fortigate-single/fgt.conf"
}

// license file for the fgt
variable "license" {
  type    = string
  default = "../fortinet/fortigate-single/FGVM4VTM21000346.lic"
}