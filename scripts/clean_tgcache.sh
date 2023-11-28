#!/bin/bash

echo "Cleaning caches ..."
find . -type d -name ".terragrunt-cache" -exec rm -rf {} +
find . -type d -name ".terraform" -exec rm -rf {} +
