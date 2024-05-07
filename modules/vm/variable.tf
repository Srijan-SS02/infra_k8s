variable "resource_group_name" {
  description = "Resource group name"
}


variable "node_type" {
  description = "Type of node (worker, master, admin)"
}

variable "node_count" {
  description = "Number of worker nodes"
}

variable "machine_size" {
  description = "Virtual machine size for each node"
}

variable "storage_size_gb" {
  description = "Storage size for each node in GB"
}


variable "name_prefix" {
  description = "Prefix for the names of the virtual machines"
}

variable "main_subnet_id" {
  description = "ID of the main subnet where VMs will be deployed"
  type        = list(string)  # Assuming the subnet IDs are strings
}