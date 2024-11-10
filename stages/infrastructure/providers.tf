# Required version of Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70"  
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47.0"  
    }
  }
  backend "azurerm" {
    use_azuread_auth = true
    
  }

}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    
  }  
  storage_use_azuread = true
}

provider "azuread" {
  
  use_msi = false
  tenant_id = data.azurerm_client_config.current.tenant_id
}