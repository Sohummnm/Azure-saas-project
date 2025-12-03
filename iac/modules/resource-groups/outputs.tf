output "rg_name" {
  description = "name of the resource group"
  value = azurerm_resource_group.rg
}

output "rg_location" {
  description = "location of the resource group"
  value = azurerm_resource_group.rg.location
}

output "rg-id" {
  description = "id of the resource group"
  value = azurerm_resource_group.rg.id
}