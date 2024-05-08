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

module "virtual_machines_master" {
  source               = "./modules/vm"
  resource_group_name  = module.resource_group.resource_group_name
  node_count           = var.master_node_count
  node_type            = "master"  
  main_subnet_id       = module.network.subnet_ids
  machine_size         = var.master_machine_size  
  storage_size_gb      = var.master_node_storage_size_gb 
  name_prefix          = "vm"
}

module "virtual_machines_worker" {
  source               = "./modules/vm"
  resource_group_name  = module.resource_group.resource_group_name
  node_count           = var.worker_node_count
  node_type            = "worker" 
  main_subnet_id       = [module.network.subnet_ids[1]]
  machine_size         = var.worker_machine_size
  storage_size_gb      = var.worker_node_storage_size_gb  
  name_prefix          = "vm"
}


module "virtual_machines_admin" {
  source               = "./modules/vm"
  resource_group_name  = module.resource_group.resource_group_name
  node_count           = var.admin_node_count
  node_type            = "admin" 
  main_subnet_id       = [module.network.subnet_ids[1]]
  machine_size         = var.admin_machine_size
  storage_size_gb      = var.admin_node_storage_size_gb  
  name_prefix          = "vm"
}

module "load_balancer" {
  source = "./modules/load_balancer"
  load_balancer_name = "k8s_loadbalancer"
  resource_group_name = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
}