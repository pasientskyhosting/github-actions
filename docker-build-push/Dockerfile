FROM docker:19.03.2
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

LABEL "com.github.actions.name"="Docker build and publish"
LABEL "com.github.actions.description"="docker build and publish to registry"
LABEL "com.github.actions.icon"="anchor"
LABEL "com.github.actions.color"="blue"
LABEL "repository"="https://github.com/pasientskyhosting/github-actions"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache git

ARG version=none
ENV VERSION=$version

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]