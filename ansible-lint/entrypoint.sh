#! /usr/bin/env bash

ACTION_PLAYBOOK_NAME="${PLAYBOOK_NAME:-playbook.yml}"
ACTION_TOOL_NAME="${TOOL_NAME:-ansible_lint}"

ACTION_PLAYBOOK_PATH="${GITHUB_WORKSPACE}/${ACTION_PLAYBOOK_NAME}"

cd "${GITHUB_WORKSPACE}"

echo "===> Running version: $VERSION"

export REVIEWDOG_GITHUB_API_TOKEN="${GITHUB_TOKEN}"

if [ ! -f "${ACTION_PLAYBOOK_PATH}" -a ! -d "${ACTION_PLAYBOOK_PATH}" ]; then
  echo "Cant find '${ACTION_PLAYBOOK_PATH}"
  exit 1
fi

ansible-lint ${ACTION_PLAYBOOK_PATH} | reviewdog -efm="%f:%l: %m" -name="${ACTION_TOOL_NAME}" -reporter=github-pr-check