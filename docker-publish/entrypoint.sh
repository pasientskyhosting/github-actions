#!/bin/sh
set -e

if [ -z "$INPUT_REPO_NAME" ]; then
  echo "Need Docker repo name e.g. pasientskyhosting/image"
  exit 1
fi

if [ -z "$INPUT_USERNAME" ]; then
  echo "Need Docker username for login"
  exit 1
fi

if [ -z "$INPUT_PASSWORD" ]; then
  echo "Need Docker password for login"
  exit 1
fi

if [ -z "$INPUT_REGISTRY" ]; then
  echo "Need Docker registry"
  exit 1
fi

if [ -z "$INPUT_TAG" ]; then
  # refs/tags/v1.2.0
  $INPUT_TAG=$(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g")
fi

echo ${INPUT_PASSWORD} | docker login -u ${INPUT_USERNAME} --password-stdin ${INPUT_REGISTRY}

DOCKERNAME="${INPUT_REPO_NAME}:${INPUT_TAG}"

docker build --build-arg version="${INPUT_TAG}" -t ${DOCKERNAME} .
docker push ${DOCKERNAME}

docker logout

time=$(date)
echo ::set-output name=build-time::$time
