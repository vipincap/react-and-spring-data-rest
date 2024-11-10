locals {
    root = "${path.root}/../.."

    env = merge(
        yamldecode(file("${local.root}/config/common.yaml")).variables,
        yamldecode(file("${local.root}/config/${var.environment}.yaml")).variables
    )

    infra_resource_group_name = "rg-infra-${local.env.location_short}-${var.environment}-01"
    acr_name                  = "assignment${local.env.location_short}${var.environment}"

    app_service_plan_name     = "app-service-plan-${local.env.location_short}-${var.environment}"
    app_service_name          = "app-service-name-${local.env.location_short}-${var.environment}"

    container_app_name        = "assignment-app-name-${local.env.location_short}-${var.environment}"

}

