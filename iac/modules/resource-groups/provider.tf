terraform {
    required_version = ">= 1.6.0, < 2.0.0"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "4.0"
      }
    }
    backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  features {}
}