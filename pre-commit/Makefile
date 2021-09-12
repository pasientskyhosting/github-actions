all: docker-build docker-run

docker-run:
	docker run --rm --name=pre-commit -v `pwd`:/home/workspace -v "/var/run/docker.sock":"/var/run/docker.sock" -e GITHUB_WORKSPACE=/home/workspace -e INPUT_IMAGE_NAME=test:latest pasientskyhosting/pre-commit-docker:latest

docker-build:
	docker build --build-arg PYTHON_VERSION='3.9.7-alpine3.14' -t pasientskyhosting/pre-commit-docker:latest .
