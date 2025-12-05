resource "azurerm_log_analytics_workspace" "monitoring" {
  name                = var.workspace_name
  location            = data.terraform_remote_state.resource_group.outputs.rg_location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
  sku                 = var.workspace_sku
  retention_in_days   = var.retention_in_days

  tags = var.tags
}
