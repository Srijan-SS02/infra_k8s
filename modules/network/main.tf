resource "azurerm_virtual_network" "main" {
  name                = "k8s-vnet"
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_cidr # Assuming you're using the first CIDR block from the list
  location            = var.location
}

resource "azurerm_subnet" "main" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnets[count.index].address_prefix]
}
