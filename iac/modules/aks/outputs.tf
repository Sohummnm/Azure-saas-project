output "aks_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

output "aks_user_node_pool_name" {
  value = azurerm_kubernetes_cluster_node_pool.user_node_pool.name
}
output "principal_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}