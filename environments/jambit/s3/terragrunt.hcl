locals {
  config = {}
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
  {}
)
