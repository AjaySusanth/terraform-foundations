variable "project_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID"
  type        = string
}

variable "app_principal_id" {
  description = "The Principal ID of the app's Managed Identity"
  type        = string
}
