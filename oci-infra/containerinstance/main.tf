data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_container_instances_container_instance" "container_instance" {
  compartment_id = var.compartment_id

  availability_domain = var.availability_domain == null ? data.oci_identity_availability_domains.ads.availability_domains[0].name : var.availability_domain
  containers {
    #Required
    image_url = var.container_instance_containers_image_url

    environment_variables = {
        APP_PLATFORM = "OCI Container Instance"
    }

  }
  shape = var.shape
  shape_config {
    memory_in_gbs = 8
    ocpus         = 1
  }
  vnics {
    subnet_id = var.subnet_id
  }

  display_name  = var.container_instance_name
  freeform_tags = var.tags
}