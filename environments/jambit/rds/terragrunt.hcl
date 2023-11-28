locals {
  config = {}
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    vpc_id = "vpc-deadbeef123456789"
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
    vpc_id = dependency.vpc.outputs.vpc_id
  }
)
