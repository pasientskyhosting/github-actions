#!/bin/sh

# Run pre-commit
################

# exit when any command fails
set -e

echo "===> Running version: $VERSION"

# The following environment variables will be provided by the environment automatically: GITHUB_WORKSPACE
mkdir -p $GITHUB_WORKSPACE
cd "${GITHUB_WORKSPACE}"

pre-commit install

exec pre-commit run -a --color always