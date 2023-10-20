
terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = false
}

provider "azapi" {
  skip_provider_registration = false
}
