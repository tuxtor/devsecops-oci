output "instance_public_ip" {
  description = "The public IP address of the container instance"
  value       =  oci_core_instance.oci_host.public_ip
}