#!/bin/sh

# Publish Docker Container To A Package Registry
####################################################

# exit when any command fails
set -e

echo "===> Running version: $VERSION"

# DESCRIPTION: NAME OF THE DOCKER REGISTRY
# DEFAULT: 'docker.io'
INPUT_IMAGE_REGISTRY=${INPUT_IMAGE_REGISTRY:-docker.io} 

# DESCRIPTION: PUSH THE ':LATEST' TAG AS WELL
# DEFAULT: 'true'
INPUT_PUSH_TAG_LATEST=${INPUT_PUSH_TAG_LATEST:-true}

# DESCRIPTION: DO NOT PUSH IMAGE TO REGISTRY. ONLY DO A TEST BUILD
# DEFAULT: 'true'
INPUT_BUILD_ONLY=${INPUT_BUILD_ONLY:-true} 

# DESCRIPTION: THE FULL PATH (INCLUDING THE FILENAME) TO THE DOCKERFILE THAT YOU WANT TO BUILD
# DEFAULT: './Dockerfile'
INPUT_DOCKERFILE_PATH=${INPUT_DOCKERFILE_PATH:-./Dockerfile} 


# check inputs
if [[ "$INPUT_BUILD_ONLY" == "false" ]]; then

  if [[ -z "$INPUT_USERNAME" ]]; then
    echo "Set the USERNAME input."
    exit 1
  fi

  if [[ -z "$INPUT_PASSWORD" ]]; then
    echo "Set the PASSWORD input."
    exit 1
  fi

  # The following environment variables will be provided by the environment automatically: GITHUB_REF, GITHUB_SHA
  if [ -z "$INPUT_IMAGE_TAG" ]; then
    # refs/tags/v1.2.0
    INPUT_IMAGE_TAG="$(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g")"
  fi

else
  INPUT_IMAGE_TAG=$(echo "${GITHUB_SHA}" | cut -c1-12)
fi

if [[ -z "$INPUT_IMAGE_NAME" ]]; then
	echo "Set the IMAGE_NAME input."
	exit 1
fi

if [[ -z "$INPUT_DOCKERFILE_PATH" ]]; then
	echo "Set the DOCKERFILE_PATH input."
	exit 1
fi

IMAGE_NAME="${INPUT_IMAGE_NAME}:${INPUT_IMAGE_TAG}"
IMAGE_NAME_LATEST="${INPUT_IMAGE_NAME}:latest"

# Build The Container
docker build \
--build-arg version="${INPUT_IMAGE_TAG}" \
-t ${IMAGE_NAME} \
-t ${IMAGE_NAME_LATEST} \
-f ${INPUT_DOCKERFILE_PATH} ${INPUT_BUILD_CONTEXT}

if [[ "$INPUT_BUILD_ONLY" == "false" ]]; then

  # send credentials through stdin (it is more secure)
  echo ${INPUT_PASSWORD} | docker login -u ${INPUT_USERNAME} --password-stdin ${INPUT_IMAGE_REGISTRY}

  # Push two versions, with and without the SHA
  docker push ${INPUT_IMAGE_REGISTRY}/${IMAGE_NAME}

  if [[ "$INPUT_PUSH_TAG_LATEST" == "true" ]]; then
    docker push ${INPUT_IMAGE_REGISTRY}/${IMAGE_NAME_LATEST}
  fi

fi 

time=$(date)

echo "::set-output name=IMAGE_FULL_NAME::${INPUT_IMAGE_REGISTRY}/${IMAGE_NAME}"
echo "::set-output name=IMAGE_BUILD_TIME::${time}"