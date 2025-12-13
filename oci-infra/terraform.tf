terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.21.0"
    }
  }

  backend "oci" {
    namespace = "idmcnnm1fqup"
    bucket    = "tf-state-bucket"
  }
}

