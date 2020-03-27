FROM python:3.8.2-alpine3.11
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

RUN pip3 install pre-commit

ARG version=none
ENV VERSION=$version

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
