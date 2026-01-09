variable "subscription_id" {
  description = "The Subscription ID to deploy to (optional)."
  type        = string
  default     = "[SUBSCRIPTION_ID]"
}

variable "tenant_id" {
  description = "The Tenant ID to use for authorization."
  type        = string
  default     = "[TENANT_ID]"
}

variable "sql_admin_username" {
  description = "The administrator username for SQL Server."
  type        = string
  default     = "[SQL_ADMIN]"
}

variable "sql_admin_password" {
  description = "The administrator password for SQL Server."
  type        = string
  default     = "[SQL_PASSWORD]"
}
