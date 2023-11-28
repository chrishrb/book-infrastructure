locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract the variables we need for easy access
  account_id = local.account_vars.locals.account_id
  region     = local.account_vars.locals.region
  profile    = local.account_vars.locals.profile

  # constants
  service_prefix = "book"
  # expected retention_in_days to be one of [0 1 3 5 7 14 30 60 90 120 150 180 365 400 545 731 1827 3653]
  log_retention_days = 30

  automation = "terraform"
  owner      = "Christoph Herb"
  project    = "Bachelor thesis"
  app        = "Book API"
}

terraform_version_constraint  = file(find_in_parent_folders(".terraform-version"))
terragrunt_version_constraint = file(find_in_parent_folders(".terragrunt-version"))

remote_state {
  backend = "s3"
  generate = {
    path      = "backend_generated.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${local.account_id}-${local.region}-terraform-state"
    encrypt        = true
    dynamodb_table = "${local.account_id}-${local.region}-terraform-state-lock"
    region         = local.region
    key            = "${local.service_prefix}-deployment/${basename(path_relative_to_include())}"
    profile        = local.profile
  }
}

generate "provider" {
  path      = "provider_generated.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "${local.region}"
  profile = "${local.profile}"
  default_tags {
    tags = {
      "book:automation" = "${local.automation}"
      "book:owner"      = "${local.owner}"
      "book:project"    = "${local.project}"
      "book:app"        = "${local.app}"
   }
 }
}
EOF
}
