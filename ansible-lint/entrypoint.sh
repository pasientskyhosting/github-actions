#! /usr/bin/env bash

set -eo pipefail
set -x

ACTION_PLAYBOOK_NAME="${INPUT_PLAYBOOK_NAME:-playbook.yml}"

set -u

cd "${GITHUB_WORKSPACE}"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

ACTION_PLAYBOOK_PATH="${GITHUB_WORKSPACE}/${ACTION_PLAYBOOK_NAME}"

echo "Looking in: $ACTION_PLAYBOOK_PATH"

if [ ! -f "${ACTION_PLAYBOOK_PATH}" -a ! -d "${ACTION_PLAYBOOK_PATH}" ]; then
  >&2 echo "==> Can't find '${ACTION_PLAYBOOK_PATH}'.
    Please ensure to set up input `playbook_name` env var
    relative to the root of your project."
  exit 1
fi

>&2 echo
>&2 echo "==> Linting ${ACTION_PLAYBOOK_PATH}…"

if [ -d "${ACTION_PLAYBOOK_PATH}" ]; then
  ansible-lint `find "${ACTION_PLAYBOOK_PATH}" -type f -name playbook.yml` \
  | reviewdog -efm="%f:%l: %m" -name="${INPUT_TOOL_NAME}" -reporter=github-pr-check -level="${INPUT_LEVEL}"
else
  ansible-lint "${ACTION_PLAYBOOK_PATH}" \
  | reviewdog -efm="%f:%l: %m" -name="${INPUT_TOOL_NAME}" -reporter=github-pr-check -level="${INPUT_LEVEL}"
fi

>&2 echo