variable "rg_name" {
  description = "name of the resource group"
  type = string
}

variable "location" {
  description = "location of the resource group"
  type = string
}

variable "tags" {
  description = "tags for the resource group"
  type = map(string)
}