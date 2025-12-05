
data "terraform_remote_state" "resource_group" {
    backend = "azurerm"
    config = {
        resource_group_name = "azure-saas-project-rg"
        storage_account_name = "azuresaasproject"
        container_name = "prod"
        key = "resource_group.tfstate"
    }
}
data "terraform_remote_state" "aks_cluster" {
    backend = "azurerm"
    config = {
        resource_group_name = "azure-saas-project-rg"
        storage_account_name = "azuresaasproject"
        container_name = "prod"
        key = "aks.tfstate"
    }
}