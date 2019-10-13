#!/bin/bash

echo "Using go get: $INPUT_GO_GET"

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

# see if we need to get dependencies
if [ "$INPUT_GO_GET" = "yes" ] || [ "$INPUT_GO_GET" = "true" ]; then
    go get -d
fi

golangci-lint run --out-format line-number ${INPUT_GOLANGCI_LINT_FLAGS} \
  | reviewdog -f=golangci-lint -name="${INPUT_TOOL_NAME}" -reporter=github-pr-check -level="${INPUT_LEVEL}"
