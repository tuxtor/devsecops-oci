variable "api_fingerprint" {
  description = "Fingerprint of OCI API private key for Tenancy"
  type        = string
}

variable "api_private_key_path" {
  description = "Path to OCI API private key used for Tenancy"
  type        = string
}

variable "api_private_key_passphrase" {
  description = "Passphrase for OCI API private key used for Tenancy"
  type        = string
}

variable "tenancy_id" {
  description = "Tenancy ID where to create resources for Tenancy"
  type        = string
}

variable "user_id" {
  description = "User ID that Terraform will use to create resources for Tenancy"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment ID where resources will be created for Tenancy"
  type        = string
}

variable "region" {
  description = "OCI region where resources will be created for Tenancy"
  type        = string
}

variable "infra_bootstrap" {
  type        = bool
  description = "Flag to indicate if the infrastructure bootstrap should be performed."
  default     = false
}
