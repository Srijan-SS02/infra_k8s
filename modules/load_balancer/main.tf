data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_public_ip" "ip_LB" {
  name                = "PublicIPForLB"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "LoadBalancer" {
  name                = var.load_balancer_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ip_LB.id
  }
}