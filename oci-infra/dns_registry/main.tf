//Create registry subdomain
resource "oci_dns_rrset" "subdomain_rrset" {
  compartment_id = var.compartment_id

  count           = var.infra_bootstrap ? 0 : 1
  zone_name_or_id = "oci.vorozco.com"
  domain          = var.dns_record.name
  rtype           = var.dns_record.type
  items {
    domain = var.dns_record.name
    rtype  = var.dns_record.type
    ttl    = var.dns_record.ttl
    rdata  = var.dns_record.record
  }
}