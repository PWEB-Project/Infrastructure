variable "gcp_credentials" {}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.21.0"
    }
  }

  backend "remote" {
    organization = "pweb-idp"

    workspaces {
      name = "pweb-idp"
    }
  }

  required_version = ">= 1.1.9"
}


