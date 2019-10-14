FROM python:3.7-slim-stretch

LABEL "maintainer"="kj@patientsky.com <kj@patientsky.com>"
LABEL "repository"="https://github.com/pasientskyhosting/github-actions"
LABEL "homepage"="https://github.com/pasientskyhosting/github-actions"

LABEL "com.github.actions.name"="ansible-lint"
LABEL "com.github.actions.description"="Run Ansible Lint"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="gray-dark"

RUN apt-get update && \
    apt-get install -y \
      curl

RUN pip install ansible-lint 
RUN curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]