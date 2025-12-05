variable "public_ip_name" {
    description = "Mention the name of Public IP"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}
