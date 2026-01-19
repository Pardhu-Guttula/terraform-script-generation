variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "tenant_id" {
  description = "The Tenant ID for the Azure Key Vault."
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL admin user."
  type        = string
}