terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.21.0"
    }
  }

  backend "oci" {
    namespace = "idemd9jasawg"
    bucket    = "tf-state-bucket"
  }
}

