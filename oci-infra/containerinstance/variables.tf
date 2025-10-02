variable "compartment_id" {
  description = "The OCID of the compartment in which to create the registry."
  type        = string
}

variable "shape" {
  description = "OCI instance shape"
  type        = string
  default     = "CI.Standard.E4.Flex"
}

variable "subnet_id" {
  description = "Subnet OCID for OCI instance"
  type        = string
}

variable "container_instance_name" {
  description = "Name for the OCI container instance"
  type        = string
  default     = "oci-container-instance"
}


variable "availability_domain" {
  description = "Availability Domain for the OCI instance"
  type        = string
  default     = null
}

variable "container_instance_containers_image_url" {
  description = "The image URL for the container instance."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
