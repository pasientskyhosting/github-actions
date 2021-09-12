ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

RUN apk update --no-cache \
    && apk add --no-cache \
    git \
    && rm -rf /var/cache/apk/*

RUN pip install pre-commit

ARG version=none
ENV VERSION=$version

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
