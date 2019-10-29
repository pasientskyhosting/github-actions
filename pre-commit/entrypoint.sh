#!/bin/bash

echo "test"
cd "$GITHUB_WORKSPACE"

echo "===> Running version: $VERSION"
echo "===> Using version: ${which pre-commit}"

/usr/local/bin/pre-commit install

exec /usr/local/bin/pre-commit run -a --color always
