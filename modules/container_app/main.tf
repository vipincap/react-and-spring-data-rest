# Container App Environment
resource "azurerm_container_app_environment" "container_env" {
  name                       = "${var.container_app_name}-env"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = var.log_analytics_workspace_id 
}

data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
}
resource "azurerm_user_assigned_identity" "app_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.container_app_name}-identity"                                                                                                                                                                                                                                              
}
resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.app_identity.principal_id
  
}
#Azure Container App with System-Assigned Identity
resource "azurerm_container_app" "app" {
  name                         = var.container_app_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.container_env.id
  revision_mode                = "Single"

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app_identity.id]
  }
  registry {
    identity = azurerm_user_assigned_identity.app_identity.id
    server   = data.azurerm_container_registry.acr.login_server
  }
  template {
    container {
      name =  "app-container"
      image  = "${var.acr_name}.azurecr.io/${var.acr_image}:${var.acr_tag}"
      cpu    = 0.5
      memory = "1.0Gi"
    }
    
  }
  
  ingress {
    external_enabled = true

    target_port = 8080
    transport = "http"
    allow_insecure_connections = true
    traffic_weight {
      percentage = 100
      latest_revision = true 
    }
    
  }
  
}

