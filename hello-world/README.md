# Hello world action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

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
      - name: Hello World
        id: hello-world
        uses: pasientskyhosting/github-actions/hello-world@v1
        with:
          who-to-greet: 'Mona the Octocat'
```

## Inputs

- `who-to-greet` : Name of person to greet **required** `default='World'`
