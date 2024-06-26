output "virtual_network_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  value = azurerm_subnet.main[*].id
}