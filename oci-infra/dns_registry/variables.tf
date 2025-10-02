variable "compartment_id" {
  description = "The OCID of the compartment in which to create the registry."
  type        = string
}

variable "dns_record" {
  description = "A list of DNS records to create in the zone."
  type = object({
    name    = string
    type    = string
    ttl     = number
    record  = string
  })
}