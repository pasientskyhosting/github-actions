# Dockerfile linter

Lint a Dockerfile, or many Dockerfiles.

## Inputs

### `dockerfile`

**Required** Path to dockerfile. Default `.`

## Outputs

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
      - name: dockerfile-linter linter
        id: dockerfile-linter-linter
        uses: ./dockerfile-linter
        with:
          dockerfile: ./path/to/project/Dockerfile
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
