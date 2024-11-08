# This is for iterating on the code rapidly without going through the No-code workflow
module "function" {
  source   = "git@github.com:nphilbrook/terraform-aws-function-with-api.git"
  basename = "function-2"
}
