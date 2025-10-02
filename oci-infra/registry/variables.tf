variable "compartment_id" {
  description = "The OCID of the compartment in which to create the registry."
  type        = string
}

variable "repository_name" {
  description = "Name of the OCI container repository."
  type        = string
  default     = "quarkus-cloud-native-workload"
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
