variable "workspace_name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}
variable "workspace_sku" {
  description = "The SKU of the Log Analytics Workspace."
  type        = string
}

variable "retention_in_days" {
  description = "The retention period for the Log Analytics Workspace in days."
  type        = number
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}