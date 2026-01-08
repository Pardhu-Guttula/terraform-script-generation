
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "example-rg"
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "West Europe"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "example-asp"
}

variable "web_app_name" {
  description = "Name of the web application"
  type        = string
  default     = "example-web-app"
}

variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
  default     = "example-sql-server"
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
  default     = "example-db"
}

variable "sql_admin_username" {
  description = "Administrator username for SQL server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Administrator password for SQL server"
  type        = string
  default     = "P@ssw0rd!"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "examplestorageacct"
}

variable "app_insights_name" {
  description = "Name of the Application Insights"
  type        = string
  default     = "example-app-insights"
}

variable "monitor_name" {
  description = "Name of the Azure Monitor"
  type        = string
  default     = "example-monitor"
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = "example-keyvault"
}

variable "tenant_id" {
  description = "Tenant ID for the Key Vault"
  type        = string
}
