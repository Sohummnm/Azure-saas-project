
resource "azurerm_container_registry" "acr" {
    name = var.acr_name
    resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
    location = data.terraform_remote_state.resource_group.outputs.rg_location
    sku = var.sku
    admin_enabled = false
    tags = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id = data.terraform_remote_state.aks_cluster.outputs.principal_id
  role_definition_name = "AcrPull"
  scope = azurerm_container_registry.acr.id
} 