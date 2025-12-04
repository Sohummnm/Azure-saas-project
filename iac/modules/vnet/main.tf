# module for vnet azure

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = data.terraform_remote_state.resource_group.outputs.rg_location
  resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name

  tags = var.tags
}

resource "azurerm_subnet" "subnets" {
    for_each = var.subnets
    name = each.key
    resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [each.value]
}