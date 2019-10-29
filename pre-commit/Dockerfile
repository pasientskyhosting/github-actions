FROM golang:alpine3.10

RUN apk update --no-cache \
    && apk add --no-cache \
    py-pip \    
    && rm -rf /var/cache/apk/*

RUN pip install pre-commit

ARG version=none
ENV VERSION=$version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
