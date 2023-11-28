# TODO: this lambda should not be necessary

locals {
  config = {}
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "vpc-deadbeef123456789"
  }
}

dependency "rds" {
  config_path = "../rds"

  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    endpoint        = "rds.us-east-1.amazonaws.com"
    master_username = "master"
    master_password = "password"
    database_name   = "book"
  }
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "git@github.com:chrishrb/book-tfmod//${basename(get_terragrunt_dir())}?ref=v0.1.0"
}

inputs = merge(
  local.config,
  include.root.locals,
  {
    lambda_binary       = "${get_parent_terragrunt_dir()}/../artifacts/migrate_function.zip"
    migration_directory = "${get_parent_terragrunt_dir()}/../artifacts/migrations"
    postgres_host       = dependency.rds.outputs.endpoint
    postgres_username   = dependency.rds.outputs.master_username
    postgres_password   = dependency.rds.outputs.master_password
    postgres_db         = dependency.rds.outputs.database_name
    vpc_id              = dependency.vpc.outputs.vpc_id,
  }
)
