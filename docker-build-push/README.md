# docker-build-push

> docker build and push to docker-hub only push tag

## Usage

```yaml
# Trigger the workflow on pull request activity
on:
  release:
    # Only use the types keyword to narrow down the activity types that will trigger your workflow.
    types: [published]

jobs:

  build-push:
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@master
      - name: Buld and publish to registry
        uses: actions/docker-tag-build-push-action@master
        with:
          repo_name: myRepo/imageName
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
```

## Required Arguments

- `repo_name` : docker hub repo
- `username` : docket hub user name for push docker image
- `password` : docket hub user password for push docker image
