# Resource group
module "resource_group" {
  source               = "./modules/resource_group/"
  resource_group_name  = "k8s_rg"
  location             = "eastus"
}


module "network" {
  source              = "./modules/network"
  resource_group_name = module.resource_group.resource_group_name
  subnets = [
    {
      name            = "master_subnet"
      address_prefix  = "10.0.1.0/24"
    },
    {
      name            = "worker_subnet"
      address_prefix  = "10.0.2.0/24"
    }
  ]
}

module "virtual_machines" {
  source               = "./modules/vm"
  resource_group_name  = module.resource_group.resource_group_name
  node_count           = var.node_count
  node_type            = "master"  # You can adjust or make this variable dynamic as needed
  main_subnet_id       = module.network.subnet_ids
  machine_size         = "Standard_DS1_v2"  # Example machine size
  storage_size_gb      = 128  # Example disk size in GB
  name_prefix          = "vm"
}