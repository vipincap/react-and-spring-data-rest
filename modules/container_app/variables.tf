# Variables for customization
variable "resource_group_name" {
    type = string
}

variable "acr_resource_group_name" {
    type = string
}
variable "location" {
    type = string
}


variable "container_app_name" {
  description = "Name of the Azure Container App"
  type        = string
  default     = "my-container-app"
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "acr_image" {
  description = "Image name in ACR to deploy in the Container App"
  type        = string
  default     = "my-app-image"  # Replace with your image name in ACR
}

variable "acr_tag" {
  description = "Tag for the image in ACR (default: latest)"
  type        = string
  default     = "latest"
}

variable "log_analytics_workspace_id" {
  type        = string
}