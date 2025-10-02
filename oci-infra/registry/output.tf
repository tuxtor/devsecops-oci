output "registry_id" {
  description = "URL of the OCI container registry for the workload."
  value       = oci_artifacts_container_repository.container_registry.id
}

