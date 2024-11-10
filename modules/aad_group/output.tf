# Output the Azure AD Group ID
output "aad_group_id" {
  description = "The object ID of the created Azure AD group."
  value       = azuread_group.aad_group.object_id
}

# Output the Azure AD Group Name
output "aad_group_name" {
  description = "The display name of the created Azure AD group."
  value       = azuread_group.aad_group.display_name
}
