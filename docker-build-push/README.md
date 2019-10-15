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

  docker_build_push_job:
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@master
      - name: Build and publish to registry
        uses: pasientskyhosting/github-actions/docker-build-push@v1
        with:
          image_name: myRepo/imageName
          build_only: 'false'
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
```

## Inputs

- `password` : Your registry password corresponding to write access to the repo where this action is called. **required**
- `username` : Your registry password corresponding to write access to the repo where this action is called. **required**
- `image_name` : name of the image.  Example - myContainer **required**
- `image_registry` : Name of the docker registry **required** default: 'docker.io'
- `image_tag` : Override docker image tag instead of using github release tag
- `build_context` : the path in your repo that will serve as the build context **required** `default: './'`
- `build_only` : do not push image to registry. Only do a test build **required** `default: 'true'`
- `dockerfile_path` : the full path (including the filename) to the dockerfile that you want to build **required** `default: ./Dockerfile`

## Outputs

- `IMAGE_FULL_NAME` : name of the Docker Image including the tag
- `IMAGE_BUILD_TIME` : time of image build
