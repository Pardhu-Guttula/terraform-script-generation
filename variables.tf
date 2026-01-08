variable "sql_admin_username" {
  description = "The admin username for the SQL Server."
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for the SQL Server."
  type        = string
}

variable "principal_id" {
  description = "The principal ID to assign the role."
  type        = string
}
