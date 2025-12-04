resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsgs
    name = each.key
    location = data.terraform_remote_state.resource_group.outputs.rg_location
    resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
    tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
    for_each = {
        aks = { subnet_id = data.terraform_remote_state.vnet.outputs.subnet_ids["aks"], nsg_name = "aks" }
        appgw = { subnet_id = data.terraform_remote_state.vnet.outputs.subnet_ids["appgw"], nsg_name = "appgw"}
        db = { subnet_id = data.terraform_remote_state.vnet.outputs.subnet_ids["db"], nsg_name = "db"}
    }
    subnet_id = each.value.subnet_id
    network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_name].id
}

resource "azurerm_network_security_rule" "aks_rules" {
    for_each = var.aks_rules
    name = each.key
    priority = each.value.priority
    direction = each.value.direction
    access = each.value.access
    protocol = each.value.protocol
    source_port_range = "*"
    destination_port_range = each.value.port
    source_address_prefix = each.value.source
    destination_address_prefix = "*"
    resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
    network_security_group_name = azurerm_network_security_group.nsg["aks"].name

}

resource "azurerm_network_security_rule" "appgw_rules" {
  for_each = var.appgw_rules
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefix       = each.value.source
  destination_address_prefix  = "*"
  resource_group_name         = data.terraform_remote_state.resource_group.outputs.rg_name
  network_security_group_name = azurerm_network_security_group.nsg["appgw"].name
}

resource "azurerm_network_security_rule" "db_rules" {
  for_each = var.db_rules
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefix       = each.value.source
  destination_address_prefix  = "*"
  resource_group_name         = data.terraform_remote_state.resource_group.outputs.rg_name
  network_security_group_name = azurerm_network_security_group.nsg["db"].name
}
