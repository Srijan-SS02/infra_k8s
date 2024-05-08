
variable "vnet_cidr" {
  description = "Address space for the virtual network"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "master_node_count" {
  description = "Number of virtual machines to create"
  type = number
}

variable "master_node_storage_size_gb" {
  description = "Storage size of each VM in Gb"
  type = number
  default = 128
}

variable "master_machine_size" {
  description = "Master Node pool machine size, eg"
  type = string
  default = "Standard_DS1_v2"
}


variable "worker_node_count" {
  description = "Number of virtual machines to create"
  type = number
}


variable "worker_node_storage_size_gb" {
  description = "Storage size of each VM in Gb"
  type = number
  default = 128
}

variable "worker_machine_size" {
  description = "Master Node pool machine size, eg"
  type = string
  default = "Standard_DS1_v2"
}


variable "admin_node_count" {
  description = "Number of virtual machines to create"
  type = number
}


variable "admin_node_storage_size_gb" {
  description = "Storage size of each VM in Gb"
  type = number
  default = 128
}

variable "admin_machine_size" {
  description = "Master Node pool machine size, eg"
  type = string
  default = "Standard_DS1_v2"
}