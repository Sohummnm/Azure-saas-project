
resource "azurerm_public_ip" "prod_appgw_pip" {
  name = var.public_ip_name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
  location = data.terraform_remote_state.resource_group.outputs.rg_location
  sku = "Standard"
  allocation_method = "Static"
  tags = var.tags
}