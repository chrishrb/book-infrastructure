#!/bin/bash

echo "removing AWS provider version lock files ..."
find . -type d -name ".terragrunt-cache" -exec rm -rf {} +
find . -type d -name ".terraform" -exec rm -rf {} +
find . -type f -name ".terraform.lock.hcl" -exec rm -f {} +
