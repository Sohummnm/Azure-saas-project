# tfsec:ignore:azure-container-limit-authorized-ips Reason: Using api_server_access_profile in provider v4.0
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name = var.cluster_name
    location = data.terraform_remote_state.resource_group.outputs.rg_location
    resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
  dns_prefix = var.dns_prefix

  api_server_access_profile {
    authorized_ip_ranges = ["10.0.0.0/16", "192.30.252.0/22", "185.199.108.0/22", "0.0.0.0/0"]
  }

  ingress_application_gateway {
    gateway_id = data.terraform_remote_state.appgw.outputs.appgw_id


  }

  default_node_pool {
    name = "system"
    node_count = 1
    vm_size = var.vm_size
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3
    vnet_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["aks"]
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr = "10.1.0.0/16"
    dns_service_ip = "10.1.0.10"
  }

  oms_agent {
    log_analytics_workspace_id = data.terraform_remote_state.log_analytics.outputs.log_analytics_workspace_id
  }

  
  identity {
    type = "SystemAssigned"
   
  }
  role_based_access_control_enabled = true

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_node_pool" {
    name = "userpool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
    vm_size = var.user_node_pool_vm_size
    node_count = 1
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3
    mode = "User"
    vnet_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["aks"]
    os_type = "Linux"
    node_public_ip_enabled = false
}

data "azurerm_user_assigned_identity" "agic_addon" {
  name                = "ingressapplicationgateway-${azurerm_kubernetes_cluster.aks_cluster.name}"
  resource_group_name = azurerm_kubernetes_cluster.aks_cluster.node_resource_group

  depends_on = [
    azurerm_kubernetes_cluster.aks_cluster
  ]
}
resource "azurerm_role_assignment" "agic_addon_appgw_contrib" {
  scope                = data.terraform_remote_state.appgw.outputs.appgw_id
  principal_id         = data.azurerm_user_assigned_identity.agic_addon.principal_id
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "agic_addon_rg_reader" {
  scope                = data.terraform_remote_state.resource_group.outputs.rg_id
  principal_id         = data.azurerm_user_assigned_identity.agic_addon.principal_id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "agic_addon_subnet_network_contrib" {
  scope                = data.terraform_remote_state.network.outputs.subnet_ids["appgw"]
  principal_id         = data.azurerm_user_assigned_identity.agic_addon.principal_id
  role_definition_name = "Network Contributor"

  depends_on = [
    data.azurerm_user_assigned_identity.agic_addon
  ]
}
