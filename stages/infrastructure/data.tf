data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "backend" {
    name = local.env["backend_resource_group_name"]
  
}

data "azurerm_container_registry" "acr" {
   name                  = local.env["container_registory_name"]
   resource_group_name   = data.azurerm_resource_group.backend.name
}

data "azurerm_log_analytics_workspace" "law" {
  name                = local.env["log_analytics_name"]
  resource_group_name = data.azurerm_resource_group.backend.name
}