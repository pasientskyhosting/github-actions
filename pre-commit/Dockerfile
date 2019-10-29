FROM golang:1.13.3-stretch

RUN apt-get update &&  apt-get install -y \
    python-pip \
    git

RUN pip install pre-commit

ARG version=none
ENV VERSION=$version

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
