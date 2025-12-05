cluster_name = "prod-aks"
vm_size = "Standard_DC2s_v3"
dns_prefix = "prodaks"
tags = {
    environment = "production"
    project     = "azure-saas-project"
}
user_node_pool_vm_size = "Standard_DC2s_v3"