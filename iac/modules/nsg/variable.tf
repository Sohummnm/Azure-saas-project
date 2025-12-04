variable "nsgs" {
  description = "A map of NSG names to create"
  type        = map(any)
}
variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
variable "aks_rules" {
  description = "A map of AKS NSG rules to create"
  type = map(object({
    priority = number
    direction = string
    access = string
    protocol = string
    port = string
    source = string
  }))
}
variable "appgw_rules" {
  type = map(object({
    priority  = number
    direction = string
    access    = string
    protocol  = string
    port      = string
    source    = string
  }))
}

variable "db_rules" {
  type = map(object({
    priority  = number
    direction = string
    access    = string
    protocol  = string
    port      = string
    source    = string
  }))
}
