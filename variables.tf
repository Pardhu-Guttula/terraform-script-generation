variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account. Must be globally unique."
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}

variable "sql_admin_user" {
  description = "The admin username for the SQL server."
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for the SQL server."
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "The name of the SQL database."
  type        = string
}

variable "function_app_name" {
  description = "The name of the Function App."
  type        = string
}

variable "logic_app_name" {
  description = "The name of the Logic App."
  type        = string
}

variable "apim_name" {
  description = "The name of the API Management service."
  type        = string
}

variable "publisher_name" {
  description = "The publisher name for the API Management service."
  type        = string
}

variable "publisher_email" {
  description = "The publisher email for the API Management service."
  type        = string
}

variable "app_insights_name" {
  description = "The name of the Application Insights."
  type        = string
}