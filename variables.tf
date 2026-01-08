variable 'resource_group_name' {
  description = 'The name of the resource group'
  type        = string
  default     = 'rg-sample'
}
variable 'location' {
  description = 'The Azure Region where the resources will be created'
  type        = string
  default     = 'East US'
}
variable 'app_service_plan_name' {
  description = 'The name of the App Service Plan'
  type        = string
  default     = 'asp-sample'
}
variable 'app_service_name' {
  description = 'The name of the App Service'
  type        = string
  default     = 'app-sample'
}
variable 'key_vault_name' {
  description = 'The name of the Key Vault'
  type        = string
  default     = 'kv-sample'
}
variable 'api_management_name' {
  description = 'The name of the API Management Service'
  type        = string
  default     = 'apim-sample'
}
variable 'sql_server_name' {
  description = 'The name of the SQL Server'
  type        = string
  default     = 'sql-server-sample'
}
variable 'sql_database_name' {
  description = 'The name of the SQL Database'
  type        = string
  default     = 'sqldb-sample'
}
variable 'cosmosdb_name' {
  description = 'The name of the CosmosDB Account'
  type        = string
  default     = 'cosmosdb-sample'
}
variable 'notification_hub_namespace_name' {
  description = 'The name of the Notification Hub Namespace'
  type        = string
  default     = 'nh-namespace-sample'
}
variable 'notification_hub_name' {
  description = 'The name of the Notification Hub'
  type        = string
  default     = 'nhub-sample'
}}