# Group name for the Azure AD group
variable "aad_group_name" {
  description = "The name of the Azure AD group."
  type        = string
  default     = "ExampleAADGroup"
}

# List of user emails to add to the group
variable "aad_user_emails" {
  description = "List of Azure AD user emails to add to the group."
  type        = list(string)
  default     = ["vipint4u@gmail.com", "d.shalini0311@gmail.com"] # Replace with actual emails
}

# Resource scope for the Contributor role assignment
variable "resource_scope" {
  description = "Scope for the Contributor role assignment (e.g., a resource group or subscription)."
  type        = string
  default     = "/subscriptions/<YOUR_SUBSCRIPTION_ID>/resourceGroups/<YOUR_RESOURCE_GROUP_NAME>" # Update with actual scope
}
