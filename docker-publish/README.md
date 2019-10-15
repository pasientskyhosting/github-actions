# docker-publish

> docker build and push to docker-hub only push tag

## Usage

```yaml
# Trigger the workflow on pull request activity
on:
  release:
    # Only use the types keyword to narrow down the activity types that will trigger your workflow.
    types: [published]

jobs:

  docker_publish_job:
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@master
      - name: Buld and publish to registry
        uses: pasientskyhosting/github-actions/docker-publish@v0.6
        with:
          repo_name: myRepo/imageName
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
```

## Inputs

- `repo_name` : Docker repo name  **required**
- `username` : Docker hub user name for push docker image  **required**
- `password` : Docker hub user password for push docker image  **required**
- `registry` : Docker registry to push against **required** `default=docker.io`
- `tag` : Override tag for docker image
