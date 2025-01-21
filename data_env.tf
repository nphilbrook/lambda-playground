module "terraform_data_env" {
  source           = "github.com/abuxton/terraform-data-env"
}

output "env_variables" {
  value       = module.terraform_data_env.environment_data_all
  description = "The versions of the modules used in this configuration and all environment variables"
}


output "terraform_module_versions" {
  value       = module.terraform_data_env.modules_json
  description = "The versions of the modules used in this configuration and all environment variables"
}
