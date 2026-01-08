variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be created."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for Azure Key Vault."
  type        = string
}