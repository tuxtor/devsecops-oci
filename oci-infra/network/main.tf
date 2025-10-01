data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.compartment_id
}

resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_id

  cidr_blocks   = [var.vcn_cidr]
  display_name  = var.name
  dns_label     = var.dns_label
  freeform_tags = var.tags
}

resource "oci_core_subnet" "public" {
  compartment_id = var.compartment_id

  count                      = length(var.public_subnet_cidrs)
  vcn_id                     = oci_core_vcn.main.id
  cidr_block                 = var.public_subnet_cidrs[count.index]
  display_name               = "PublicSubnet-${var.name}-${count.index}"
  availability_domain        = data.oci_identity_availability_domains.availability_domains.availability_domains[count.index].name
  prohibit_public_ip_on_vnic = false
  freeform_tags              = var.tags
}

resource "oci_core_subnet" "private" {
  compartment_id = var.compartment_id

  count               = length(var.private_subnet_cidrs)
  vcn_id              = oci_core_vcn.main.id
  cidr_block          = var.private_subnet_cidrs[count.index]
  display_name        = "PrivateSubnet-${var.name}-${count.index}"
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[count.index].name

  freeform_tags = var.tags
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id

  vcn_id       = oci_core_vcn.main.id
  display_name = "${var.name}-igw"
  enabled      = true
}