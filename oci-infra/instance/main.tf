data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_instance" "oci_host" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain == null? data.oci_identity_availability_domains.ads.availability_domains[0].name: var.availability_domain
  shape               = var.shape

  display_name = var.instance_name

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  create_vnic_details {
    subnet_id = var.subnet_id
  }

  shape_config {
    memory_in_gbs = 8
    ocpus         = 1
  }

  # Optional: Add NSG IDs if you use network security groups
  # nsg_ids = [var.nsg_id] # You may need to add this variable

  freeform_tags = var.tags
}
