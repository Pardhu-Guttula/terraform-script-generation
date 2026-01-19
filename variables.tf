variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "sql_admin_username" {
  description = "Administrator username for SQL"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for SQL"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Tenant ID for Azure"
  type        = string
}

variable "role_definition_name" {
  description = "Name of the role definition"
  type        = string
}

variable "organization_name" {
  description = "Name of the organization for Azure DevOps"
  type        = string
}

variable "principal_id" {
  description = "Principal ID for role assignment"
  type        = string
}
