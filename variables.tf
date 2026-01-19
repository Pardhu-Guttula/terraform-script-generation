variable 'resource_group_name' {
  description = 'The name of the resource group in which to create resources'
  type        = string
}

variable 'location' {
  description = 'The Azure region where the resources will be created'
  type        = string
}

variable 'sql_password' {
  description = 'The password for the SQL Server administrator'
  type        = string
  sensitive   = true
}
