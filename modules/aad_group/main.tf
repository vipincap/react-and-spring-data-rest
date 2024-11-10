# Create an Azure AD Group
resource "azuread_group" "aad_group" {
  display_name     = var.aad_group_name
  security_enabled = true
  mail_enabled     = false
}

# Lookup each user by email
data "azuread_user" "lookup" {
  for_each = toset(var.aad_user_emails)
  user_principal_name = each.key
}

# Add each user to the group
resource "azuread_group_member" "aad_group_members" {
  for_each        = data.azuread_user.lookup
  group_object_id = azuread_group.aad_group.object_id
  member_object_id = each.value.id
}

# Assign Contributor Role to the Group
resource "azurerm_role_assignment" "aad_group_contributor_assignment" {
  scope                = var.resource_scope
  role_definition_name = "Reader"
  principal_id         = azuread_group.aad_group.object_id
}

