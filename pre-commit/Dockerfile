FROM golang:1.13.1-stretch
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

RUN apt-get update && apt-get install -y \
    python3-pip git

RUN pip3 install pre-commit

ARG version=none
ENV VERSION=$version

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]