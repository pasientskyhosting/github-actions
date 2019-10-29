FROM ubuntu:18.04

RUN apt-get update &&  apt-get install -y python-pip

RUN pip install pre-commit

ARG version=none
ENV VERSION=$version

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
