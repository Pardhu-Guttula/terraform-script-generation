variable "sql_admin_user" {
  description = "The administrator username for SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for SQL Server"
  type        = string
  sensitive   = true
}

variable "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID"
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for Key Vault"
  type        = string
}

variable "principal_id" {
  description = "The Principal ID for role assignment"
  type        = string
}

variable "role_definition_name" {
  description = "The Role Definition Name for role assignment"
  type        = string
}

variable "project_id" {
  description = "The Azure DevOps Project ID"
  type        = string
}