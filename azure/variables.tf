variable "group_name" {
  type = string
}
variable "region" {
  type = string
}
variable "deploy_fadc" {
  type = bool
}

variable "deploy_fgt" {
  type = bool
}



variable "vnets" {
  type = map(object({
    name = string
    cidr = string
  }))
}

variable "subnets" {
  type = map(object({
    name   = string
    vnet   = string
    subnet = string
  }))
}

variable "storage_account" {
  description = "Storage Account Names"
}

variable "routes" {
  description = "Routes"
}

variable "route_tables" {
  description = "Route Tables"
}

variable "subnet_route_table_associations" {
  description = "Route Table Associations"
}
