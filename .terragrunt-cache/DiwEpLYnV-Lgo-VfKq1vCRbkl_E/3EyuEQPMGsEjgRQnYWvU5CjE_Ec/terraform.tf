# Provider

terraform {
    required_providers {
      azurearm = {
        source = "hashicorp/azurerm"
        version = "3.105.0"
      }
    }
}

#Provider Config

provider "azurearm" {
    features {
      
    }
}