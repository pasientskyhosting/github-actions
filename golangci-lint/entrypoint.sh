#!/bin/bash

echo $INPUT_GO_GET
echo $INPUT_LEVEL

cd "$GITHUB_WORKSPACE"

echo "===> Running version: $VERSION"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

# see if we need to get dependencies
if [ "$INPUT_GO_GET" != "no" ] && [ "$INPUT_GO_GET" != "false" ]; then
    go get -d ${INPUT_GO_GET}
fi

golangci-lint run --out-format line-number ${INPUT_GOLANGCI_LINT_FLAGS} \
  | reviewdog -f=golangci-lint -name="${INPUT_TOOL_NAME}" -reporter=github-pr-check -level="${INPUT_LEVEL}"
