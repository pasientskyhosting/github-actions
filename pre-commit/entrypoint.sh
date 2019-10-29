#!/bin/bash

cd "$GITHUB_WORKSPACE"

pwd

ls -lastr

which git
which pre-commit

echo "===> Running version: $VERSION"

/usr/local/bin/pre-commit install

exec /usr/local/bin/pre-commit run -a --color always
