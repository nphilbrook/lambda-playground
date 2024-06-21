terraform {
  cloud {
    organization = "philbrook"

    workspaces {
      name = "lambda-playground"
    }
  }
}
