variable "location" {
  default     = "eastus"
  description = "Location"
}

variable "vnet_cidr" {
  type        = list(string)
  default     = ["10.0.0.0/16"] 
  description = "Address space for the virtual network"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "subnets" {
  description = "List of subnet configurations"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}