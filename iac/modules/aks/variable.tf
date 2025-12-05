variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "vm_size" {
  description = "The size of the VM for the default node pool."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
variable "user_node_pool_vm_size" {
  description = "The size of the VM for the user node pool."
  type        = string
}