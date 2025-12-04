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
  subscription_id = "1460ff46-1cc6-4ab3-846c-f4cd40286842"
  features {}
}