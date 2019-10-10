FROM replicated/dockerfilelint:be1f746
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

LABEL "com.github.actions.name"="Dockerfile Linter"
LABEL "com.github.actions.description"="Lint a Dockerfile, or many Dockerfiles"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	jq

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]