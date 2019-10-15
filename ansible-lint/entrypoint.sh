#! /usr/bin/env bash

ACTION_PLAYBOOK_NAME="${INPUT_PLAYBOOK_NAME:-playbook.yml}"

cd "${GITHUB_WORKSPACE}"

ACTION_PLAYBOOK_PATH="${GITHUB_WORKSPACE}/${ACTION_PLAYBOOK_NAME}"

if [ ! -f "${ACTION_PLAYBOOK_PATH}" -a ! -d "${ACTION_PLAYBOOK_PATH}" ]; then
  echo "==> Can't find '${ACTION_PLAYBOOK_PATH}"
  exit 1
fi

#echo "==> Linting ${ACTION_PLAYBOOK_PATH}"

ansible-lint ${ACTION_PLAYBOOK_PATH} -p | reviewdog -efm="%f:%l: %m" -name="ansible_lint_output" -reporter=github-check
