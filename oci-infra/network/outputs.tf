output "vpc_id" {
  description = "The ID of the VPC"
  value       = oci_core_vcn.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = oci_core_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = oci_core_subnet.private[*].id
}