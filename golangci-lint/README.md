# golangci-lint with reviewdog

This action runs [golangci-lint](https://github.com/golangci/golangci-lint) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Usage

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
        uses: pasientskyhosting/github-actions/golangci-lint@v1
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
        uses: pasientskyhosting/github-actions/golangci-lint@v1
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
        uses: pasientskyhosting/github-actions/golangci-lint@v1
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
        uses: pasientskyhosting/github-actions/golangci-lint@v1
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
        uses: pasientskyhosting/github-actions/golangci-lint@v1
        with:
          github_token: ${{ secrets.github_token }}
          golangci_lint_flags: "--enable-all --exclude-use-default=false"
```

## Inputs

- `github_token` : GITHUB_TOKEN **required**
- `golangci_lint_flags` : golangci-lint flags. (golangci-lint run --out-format=line-number <golangci_lint_flags>)
- `tool_name` : Tool name to use for reviewdog reporter `default='golangci_lint_output'`
- `level` : Report level for reviewdog [info,warning,error] `default='error'`
- `go_get` : Downloads the packages named by the import paths `default='no'`
