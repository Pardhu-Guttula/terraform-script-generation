variable "location" {
  description = "Location of the resources."
  type        = string
  default     = "East US"
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID for monitoring."
  type        = string
}

variable "sql_password" {
  description = "Admin password for SQL Server."
  type        = string
  sensitive   = true
}
