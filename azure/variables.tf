
variable "group_name" {
  type = string
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

variable "hub-subnets" {
  type = map(object({
    name   = string
    subnet = string
  }))
}

variable "spoke-subnets" {
  type = map(object({
    name   = string
    subnet = string
  }))
}
