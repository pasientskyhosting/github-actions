# Container image that runs your code
FROM alpine:3.13.8
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

LABEL "com.github.actions.name"="Hello World"
LABEL "com.github.actions.description"="Greet someone and record the time"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]