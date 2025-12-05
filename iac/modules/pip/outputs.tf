output "public_ip_id" {
  description = "Resource ID of the Public IP"
  value       = azurerm_public_ip.prod_appgw_pip.id
}

output "public_ip_address" {
  description = "Actual IP address"
  value       = azurerm_public_ip.prod_appgw_pip.ip_address
}