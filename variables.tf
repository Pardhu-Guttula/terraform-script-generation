variable "tenant_id" {
  description = "The Tenant ID for the Azure subscription."
  type        = string
}

variable "sql_admin_user" {
  description = "The admin username for the SQL server."
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for the SQL server."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for monitoring."
  type        = string
}
