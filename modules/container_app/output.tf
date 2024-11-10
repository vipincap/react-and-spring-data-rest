output "container_app_fqdn" {
  description = "Fully qualified domain name of the Container App"
  value       = azurerm_container_app.app.latest_revision_fqdn
}


# output "container_app_principal_id" {
#   value = azurerm_container_app.app.
#   description = "The Principal ID of the system-assigned identity for the Container App"
# }