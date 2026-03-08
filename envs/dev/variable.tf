variable "project_name" {
  description = "Base name for all resources"
  type = string
}

variable "location" {
    description = "Azure region"
    type = string
    default = "Central India"
}
