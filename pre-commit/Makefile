all: docker-build docker-run

docker-run:
	docker run --rm --name=pre-commit -v `pwd`:/root pasientskyhosting/pre-commit-docker:latest

docker-build:
	docker build -t pasientskyhosting/pre-commit-docker:latest .
