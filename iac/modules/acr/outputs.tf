output "acr_id" {
  description = "Resource ID of the ACR"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "Login server URL of the ACR"
  value       = azurerm_container_registry.acr.login_server
}