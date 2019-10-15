#! /usr/bin/env bash

ACTION_PLAYBOOK_NAME="${INPUT_PLAYBOOK_NAME:-playbook.yml}"

ACTION_PLAYBOOK_PATH="${GITHUB_WORKSPACE}/${ACTION_PLAYBOOK_NAME}"

cd "${GITHUB_WORKSPACE}"

echo "===> Running version: $VERSION"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

if [ ! -f "${ACTION_PLAYBOOK_PATH}" -a ! -d "${ACTION_PLAYBOOK_PATH}" ]; then
  echo "Cant find '${ACTION_PLAYBOOK_PATH}"
  exit 1
fi

ansible-lint ${ACTION_PLAYBOOK_PATH} | reviewdog -efm="%f:%l: %m" -name="${INPUT_TOOL_NAME}" -reporter=github-pr-check