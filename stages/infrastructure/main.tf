

# create aad group and user 
# module "multiple_account" {
#   source = "../../modules/aad_group"
#   aad_group_name = "assignment"
#   aad_user_emails = ["vipint4u@gmail.com", "d.shalini0311@gmail.com"]
#   resource_scope = "/subscriptions/583b5ead-0e91-4279-8116-4e48c71009b7"
# }




# #resource group for infra 
module "infra-rg" {
  source = "../../modules/resource_group"
  resource_group_name = local.infra_resource_group_name
  location = local.env["location"]
}

module "container_app" {
  source                     = "../../modules/container_app"
  resource_group_name        = module.infra-rg.name
  location                   = module.infra-rg.resource_group_location
  container_app_name         = local.container_app_name
  acr_name                   = data.azurerm_container_registry.acr.name
  acr_resource_group_name    = data.azurerm_resource_group.backend.name
  acr_image                  = local.env.container_image_name
  acr_tag                    = local.env.container_image_tag
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
 }


