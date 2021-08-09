variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
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
  type    = string
  default = "fad-vm-byol"
}

variable "fadcversion" {
  type    = string
  default = "6.1.2"
}

variable "adminusername" {
  type    = string
  default = "azureuser"
}

variable "adminpassword" {
  type    = string
  default = "123Password#@!"
}

variable "licenseA" {
  type    = string
  default = "../fortinet/fortiadc-ha-ap/FADV040000216490.lic"
}
variable "licenseB" {
  type    = string
  default = "../fortinet/fortiadc-ha-ap/FADV040000216491.lic"
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

variable "fadc1" {
  description = "Network Security Groups"
}
variable "fadc2" {
  description = "Network Security Groups"
}

variable "fadc_vmsize" {
  type    = string
  default = "Standard_B4ms"
}
variable "fadc_PUBLISHER" {
  type    = string
  default = "fortinet"
}
variable "fadc_IMAGE_SKU" {
  type    = string
  default = "fad-vm-byol"
}
variable "fadc_VERSION" {
  type    = string
  default = "6.1.2"
}
variable "fadc_OFFER" {
  type    = string
  default = "fortinet-fortiadc"
}
variable "vmbootdiagstorage" {
  type    = string
  default = "facserial"
}
variable "username" {
  type    = string
  default = ""
}
variable "password" {
  type    = string
  default = ""
}