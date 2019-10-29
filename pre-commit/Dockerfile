FROM python:3.7-stretch

RUN pip install pre-commit

ARG version=none
ENV VERSION=$version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
