# Dockerfile linter

Lint a Dockerfile, or many Dockerfiles.

## Inputs

### `dockerfile`

**Required** Path to dockerfile. Default `.`

## Outputs

## Example usage

uses: pasientskyhosting/github-actions/dockerfile-linter@v1
with:
  dockerfile: "./some/other/directory/Dockerfile"
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
