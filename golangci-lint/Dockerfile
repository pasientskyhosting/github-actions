FROM golang:1.18

RUN curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh    | sh -s -- -b $(go env GOPATH)/bin v0.9.13
RUN curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.19.1

ARG version=none
ENV VERSION=$version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]