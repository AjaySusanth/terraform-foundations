variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "Azure region"
}

variable "vnet_name" {
    type = string
    description = "Name of the virtual network"
}

variable "address_space" {
    type = list(string)
    description = "Address space for the VNet"
}

variable "subnets" {
    type = map(string)
    description = "Map of subnets to create"
    default = {
      "web-subnet" = "10.0.1.0/24"
    }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "nsg_name" {
    type = string
    description = "Name of the network security group"
  
}

variable "nsg_rules" {
  description = "A list of objects for NSG rules"
  type = list(object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  }))

  default = []
}
