
variable "group_name" {
  type = string
}

variable "deploy_fadc" {
  type = bool
}

variable "deploy_fgt" {
  type = bool
}

variable "region" {
  type = string
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

variable "nsgs" {
  description = "Network Security Groups"
}

variable "nsgrules" {
  description = "Network Security Group Rules"
}
