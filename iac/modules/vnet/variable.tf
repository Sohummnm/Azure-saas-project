variable "vnet_name" {
    description = "Enter the vnet name"
    type        = string
}
variable "address_space" {
    description = "CIDR - Enter the address space for the vnet"
    type        = list(string)
}
variable "tags" {
    description = "Tags to be applied to resources"
    type        = map(string)
    default     = {}
}
variable "subnets" {
    description = "A map of subnet names to address prefixes"
    type        = map(string)
}