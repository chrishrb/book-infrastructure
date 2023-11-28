# Infrastructure for book application

Infrastructure for the bachelor thesis book application by Christoph Herb.

This repo contains Terragrunt code with multi accounts support. Terragrunt calls Terraform modules in the
[book-tfmod repository](https://github.com/cherb/book-tfmod).

## Getting started

```bash
# Go to env
cd environments/jambit

# Validate / plan / apply
terragrunt run-all validate
terragrunt run-all plan
terragrunt run-all apply

# Format
terragrunt hclfmt
```

## Used software

required software:

- [tgenv](https://github.com/cunymatthieu/tgenv): Version manager for Terragrunt
- [tfenv](https://github.com/tfutils/tfenv): Version namager for Terraform

implicit installed software by tfenv and tgenv :

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Author

Christoph Herb
