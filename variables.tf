variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "app_insights_name" {
  description = "The name of Application Insights"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID"
  type        = string
}

variable "eventgrid_topic_name" {
  description = "The name of the Event Grid Topic"
  type        = string
}
