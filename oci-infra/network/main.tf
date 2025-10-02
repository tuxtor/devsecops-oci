resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_id

  cidr_blocks   = [var.vcn_cidr]
  display_name  = var.name
  dns_label     = var.dns_label
  freeform_tags = var.tags
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id

  vcn_id       = oci_core_vcn.main.id
  display_name = "${var.name}-igw"
  enabled      = true
}

resource "oci_core_subnet" "private" {
  compartment_id = var.compartment_id

  count                      = length(var.private_subnet_cidrs)
  vcn_id                     = oci_core_vcn.main.id
  cidr_block                 = var.private_subnet_cidrs[count.index]
  display_name               = "PrivateSubnet-${var.name}-${count.index}"
  prohibit_public_ip_on_vnic = true
  freeform_tags              = var.tags
}

resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_id

  vcn_id       = oci_core_vcn.main.id
  display_name = "${var.name}-public-rt"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
  freeform_tags = var.tags
}

resource "oci_core_subnet" "public" {
  compartment_id = var.compartment_id

  count                      = length(var.public_subnet_cidrs)
  vcn_id                     = oci_core_vcn.main.id
  cidr_block                 = var.public_subnet_cidrs[count.index]
  display_name               = "PublicSubnet-${var.name}-${count.index}"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "public${count.index}"
  route_table_id             = oci_core_route_table.public_rt.id
  freeform_tags              = var.tags
  security_list_ids          = [oci_core_security_list.public_http.id]
}