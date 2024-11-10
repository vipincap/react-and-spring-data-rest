variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
}

variable "acr_name" {
  type        = string
  description = "The globally unique name for the ACR instance"
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "The SKU tier for the ACR (options: Basic, Standard, Premium)"
}