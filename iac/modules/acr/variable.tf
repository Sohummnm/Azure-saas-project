variable "acr_name" {
  description = "Name of the AzureContainer Registry"
  type = string
}

variable "sku" {
  description = "SKU of the ACR (Basic, Standard, Premium)"
  type = string
}
variable "tags" {
  description = "Tags to apply to the ACR"
  type        = map(string)
  default     = {}
}
