terraform {
  required_version = ">= 1.9.3"
  required_providers {
    oci = {
      version = ">= 6.6.0"
    }
  }
}

# if you are deploying the resource outside your home region uncomment this part of the code
/*
provider "oci" {
  alias        = "oci-gru"
  tenancy_ocid = "<your id>"
  region       = "<region name>"
}*/