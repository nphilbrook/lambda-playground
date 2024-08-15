terraform {
  required_version = "~>1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.55"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~>2.4"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}
