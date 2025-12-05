
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name = var.cluster_name
    location = data.terraform_remote_state.resource_group.outputs.location
    resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
  dns_prefix = var.dns_prefix

  default_node_pool {
    name = "system"
    node_count = 1
    vm_size = var.vm_size
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3
    vnet_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["aks"]
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
}