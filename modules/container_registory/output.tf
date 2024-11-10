output "container_registry_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "container_registry_login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = azurerm_container_registry.acr.login_server
}