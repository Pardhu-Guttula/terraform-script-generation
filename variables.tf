variable "location" {
  description = "The Azure Region"
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "banking-portal-rg"
}

variable "sql_password" {
  description = "Password for SQL Server admin"
  type        = string
  sensitive   = true
}
