provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "created-by"       = "terraform"
      "source-workspace" = terraform.workspace
    }
  }
}
