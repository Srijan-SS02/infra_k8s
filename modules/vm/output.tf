output "virtual_machine_ids" {
  value = azurerm_virtual_machine.main[*].id
}