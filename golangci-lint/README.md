# GitHub Action: Run golangci-lint with reviewdog

This action runs [golangci-lint](https://github.com/golangci/golangci-lint) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Inputs

### `github_token`

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`'.

### `golangci_lint_flags`

Optional. golangci-lint flags. (golangci-lint run --out-format=line-number
`<golangci_lint_flags>`)

Note that you can change golangci-lint behavior by [configuration
file](https://github.com/golangci/golangci-lint#configuration) too.

### `tool_name`

Optional. Tool name to use for reviewdog reporter. Useful when running multiple
actions with different config.

### `level`

Optional. Report level for reviewdog [info,warning,error].
It's same as `-level` flag of reviewdog.

## Example usage

### Minimum Usage Example

```yml
name: reviewdog
on: [pull_request]
jobs:
  golangci-lint:
    name: runner / golangci-lint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint
        uses: pasientskyhosting/action-golangci-lint@v1
        # uses: docker://pasientskyhosting/action-golangci-lint:v1 # pre-build docker image
        with:
          github_token: ${{ secrets.github_token }}
```

### Advanced Usage Example

```yml
name: reviewdog
on: [pull_request]
jobs:
  # NOTE: golangci-lint doesn't report multiple errors on the same line from
  # different linters and just report one of the errors?

  golangci-lint:
    name: runner / golangci-lint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint
        uses: docker://pasientskyhosting/action-golangci-lint:v1 # Pre-built image
        # uses: pasientskyhosting/action-golangci-lint@v1 # Build with Dockerfile
        # uses: docker://pasientskyhosting/action-golangci-lint:v1.0.2 # Can use specific version.
        # uses: pasientskyhosting/action-golangci-lint@v1.0.2 # Can use specific version.
        with:
          github_token: ${{ secrets.github_token }}
          # Can pass --config flag to change golangci-lint behavior and target
          # directory.
          golangci_lint_flags: "--config=.github/.golangci.yml ./testdata"

  # Use golint via golangci-lint binary with "warning" level.
  golint:
    name: runner / golint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golint
        uses: pasientskyhosting/action-golangci-lint@v1
        with:
          github_token: ${{ secrets.github_token }}
          golangci_lint_flags: "--disable-all -E golint"
          tool_name: golint # Change reporter name.
          level: warning # GitHub Status Check won't become failure with this level.

  # You can add more and more supported linters with different config.
  errcheck:
    name: runner / errcheck
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: errcheck
        uses: pasientskyhosting/action-golangci-lint@v1
        with:
          github_token: ${{ secrets.github_token }}
          golangci_lint_flags: "--disable-all -E errcheck"
          tool_name: errcheck
          level: info
```

### All-in-one golangci-lint configuration without config file

```yml
name: reviewdog
on: [pull_request]
jobs:
  golangci-lint:
    name: runner / golangci-lint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint
        uses: pasientskyhosting/action-golangci-lint@v1
        with:
          github_token: ${{ secrets.github_token }}
          golangci_lint_flags: "--enable-all --exclude-use-default=false"
```
