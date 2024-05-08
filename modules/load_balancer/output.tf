output "load_balancer_id" {
  description = "The ID of the Azure Load Balancer"
  value       = azurerm_lb.LoadBalancer.id
}

output "frontend_ip_address" {
  description = "The frontend IP address of the Azure Load Balancer"
  value       = azurerm_public_ip.public_ip_LB.id
}

output "backend_pool_id" {
  description = "The ID of the backend pool associated with the Azure Load Balancer"
  value       = azurerm_lb_backend_address_pool.backend_pool.id
}
