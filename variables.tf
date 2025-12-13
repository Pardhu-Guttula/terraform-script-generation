variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan"
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
}

variable "app_insights_name" {
  description = "The name of the Application Insights resource"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "eventhub_namespace_name" {
  description = "The name of the Event Hub namespace"
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for Azure Key Vault"
  type        = string
}
