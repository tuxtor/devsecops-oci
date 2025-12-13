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
    user_data = base64encode(<<-EOF
    #!/bin/bash
    set -e

    # on Oracle Linux
    if command -v dnf >/dev/null 2>&1; then
      sudo dnf -y install firewalld
    else
      sudo yum -y install firewalld
    fi
    sudo firewall-cmd --permanent --add-port=80/tcp
    sudo firewall-cmd --reload

    # Install Docker (container runtime) on Oracle Linux
    if command -v dnf >/dev/null 2>&1; then
      dnf -y install docker
    else
      yum -y install docker
    fi
    systemctl enable --now podman

    # Pull a public image that listens on port 8080 and run it mapping host 80 -> container 8080
    docker pull docker.io/tuxtor/quarkus-cloud-native-workload:latest
    docker stop oci_app || true
    docker rm oci_app || true
    docker run -d --name oci_app -p 80:8080 docker.io/tuxtor/quarkus-cloud-native-workload:latest
    EOF
    )
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
