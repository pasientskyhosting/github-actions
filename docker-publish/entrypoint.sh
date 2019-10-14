#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo "Need Docker repo name e.g. pasientskyhosting/image"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Need Docker username for login"
  exit 1
fi

if [ -z "$3" ]; then
  echo "Need Docker password for login"
  exit 1
fi

if [ -z "$4" ]; then
  echo "Need Docker registry"
  exit 1
fi

if [ -z "$5" ]; then
  # refs/tags/v1.2.0
  TAG=$(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g")
fi

INPUT_REPO_NAME=$1
INPUT_USERNAME=$2
INPUT_PASSWORD=$3
INPUT_REGISTRY=$4

echo ${INPUT_PASSWORD} | docker login -u ${INPUT_USERNAME} --password-stdin ${INPUT_REGISTRY}

DOCKERNAME="${INPUT_REPO_NAME}:${TAG}"

docker build --build-arg version="${TAG}" -t ${DOCKERNAME} .
docker push ${DOCKERNAME}

docker logout

time=$(date)
echo ::set-output name=build-time::$time