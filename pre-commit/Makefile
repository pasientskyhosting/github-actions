all: docker-build docker-run

docker-run:
	docker run --rm --name=pre-commit -v `pwd`:/root -e GITHUB_WORKSPACE=/home/workspace -e INPUT_IMAGE_NAME=hest:latest pasientskyhosting/pre-commit-docker:latest

docker-build:
	docker build -t pasientskyhosting/pre-commit-docker:latest .
