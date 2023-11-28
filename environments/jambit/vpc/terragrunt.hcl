locals {
  config = {}
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "git@github.com:chrishrb/book-tfmod//${basename(get_terragrunt_dir())}?ref=v0.1.1"
}

inputs = merge(
  local.config,
  include.root.locals,
  {
    vpc_name = "main-vpc"
    cidr     = "172.16.0.0/16"
  }
)
