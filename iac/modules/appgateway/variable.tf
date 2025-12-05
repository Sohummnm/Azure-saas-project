# Core
variable "appgw_name" {
  description = "Name of the Application Gateway"
  type        = string
}

variable "sku_name" {
  description = "SKU name: Standard_v2 or WAF_v2"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier: Standard_v2 or WAF_v2"
  type        = string
}

# Capacity controls
variable "sku_capacity" {
  description = "Instance count (used if autoscale is not expanding)"
  type        = number
}

variable "backend_ips" {
}


# Tags
variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "agic_identity_name" {
  description = "Mention AGIC UAMI name"
}