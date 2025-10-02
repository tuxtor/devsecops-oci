resource "oci_artifacts_container_repository" "container_registry" {
  compartment_id = var.compartment_id
  display_name   = var.repository_name
  is_public      = false
}

