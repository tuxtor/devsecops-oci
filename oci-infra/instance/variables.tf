variable "shape" {
  description = "OCI instance shape"
  type        = string
  default     = "VM.Standard.E5.Flex"
}

variable "instance_name" {
  description = "Name for the OCI compute instance"
  type        = string
  default     = "oci-instance"
}

variable "subnet_id" {
  description = "Subnet OCID for OCI instance"
  type        = string
}

variable "compartment_id" {
  description = "Compartment OCID for OCI resources"
  type        = string
}

variable "image_id" {
  description = "OCI image OCID for the instance"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for instance access"
  type        = string
}

variable "nsg_id" {
  description = "Network Security Group OCID (optional)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
