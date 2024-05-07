
variable "vnet_cidr" {
  description = "Address space for the virtual network"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "node_count" {
  description = "Number of virtual machines to create"
}