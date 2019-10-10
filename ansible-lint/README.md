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
        uses: pasientskyhosting/github-actions/ansible-lint@v1
        with:
          dockerfile: ./path/to/project/Dockerfile
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Required Arguments

- `repo_name` : docker hub repo
- `username` : docket hub user name for push docker image
- `password` : docket hub user password for push docker image
