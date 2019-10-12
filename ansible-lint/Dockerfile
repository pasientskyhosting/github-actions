FROM yokogawa/ansible-lint:latest
LABEL maintainer="Karsten Jakobsen <kj@patientsky.com>"

LABEL "com.github.actions.name"="Ansible Lint"
LABEL "com.github.actions.description"="Run ansible-lint"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="red"
LABEL "repository"="https://github.com/pasientskyhosting/github-actions"

RUN apk --no-cache add \
    jq \
    curl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]