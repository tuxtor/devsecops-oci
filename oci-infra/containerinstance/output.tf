//Get public ip
data "oci_core_vnic" "vnic" {
  vnic_id = oci_container_instances_container_instance.container_instance.vnics[0].vnic_id
}

output "container_instance_public_ip" {
  description = "The public IP address of the container instance"
  value       =  data.oci_core_vnic.vnic.public_ip_address
}
