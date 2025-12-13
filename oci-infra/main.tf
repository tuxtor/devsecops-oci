data "oci_core_images" "oracle_linux" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = "VM.Standard.E5.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

locals {
  project_name = "tofu"
  global_tags = {
    Project = local.project_name
  }
}

module "network" {
  source               = "./network"
  compartment_id       = var.compartment_ocid
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  vcn_cidr             = "10.0.0.0/16"
  tags                 = local.global_tags
  name                 = "tf-vorozco-vcn"
}

module "raw_instance" {
  count          = 0
  source         = "./instance"
  compartment_id = var.compartment_ocid
  shape          = "VM.Standard.E5.Flex"
  image_id       = data.oci_core_images.oracle_linux.images[0].id
  subnet_id      = module.network.public_subnet_ids[0]
  instance_name  = "tf-vorozco-instance"
  tags           = local.global_tags
  ssh_public_key = file("./id_ed25519.pub")
}

module "quarkus_cloud_native_workload" {
  source                                  = "./containerinstance"
  compartment_id                          = var.compartment_ocid
  subnet_id                               = module.network.public_subnet_ids[0]
  container_instance_name                 = "quarkus-cloud-native-workload"
  container_instance_containers_image_url = "docker.io/tuxtor/quarkus-cloud-native-workload:latest"
  tags                                    = local.global_tags
  #count                                   = var.infra_bootstrap ? 0 : 1
  count = 0
}

module "quarkus_registry" {
  source          = "./registry"
  compartment_id  = var.compartment_ocid
  repository_name = "quarkus-cloud-native-workload"
  tags            = local.global_tags
}

module "quarkus_container_dns_registry" {
  source         = "./dns_registry"
  compartment_id = var.compartment_ocid
  dns_record = {
    name   = "quarkus.tf.vorozco.com"
    type   = "A"
    ttl    = 300
    record = module.quarkus_cloud_native_workload[0].container_instance_public_ip
  }
  #count = var.infra_bootstrap ? 0 : 1
  count = 0
}

