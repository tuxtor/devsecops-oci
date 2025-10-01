variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "name" {
  description = "Name tag for the VCN and subnets"
  type        = string
  default     = "vorozco-vcn"
}

variable "dns_label" {
  description = "DNS label for the VCN"
  type        = string
  default     = "vorozco"
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "compartment_id" {
  description = "Compartment ID where resources will be created for VCN"
  type        = string
}