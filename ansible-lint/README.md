# ansible-lint

> Run ansible-lint

## Usage

```yaml
# Trigger the workflow on pull request activity
on:
  pull_request:
    branches:
    - master
    - development

jobs:

  build-push:
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@master
      - name: ansible-lint
        id: ansible-lint
        uses: pasientskyhosting/github-actions/ansible-lint@master
        with:
          playbook_name: "playbook.yml"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

- `github_token` : 'GITHUB_TOKEN' **required**
- `playbook_name` : Name of playbook to lint **required**
- `tool_name:` : Reviewdog identifier `default=ansible_lint_output`
