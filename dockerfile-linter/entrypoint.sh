#!/bin/bash
set -e

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "The GITHUB_TOKEN is required."
	exit 1
fi

if [[ -z "$DOCKERFILE_PATH" ]]; then
	# DESCRIPTION: THE FULL PATH (INCLUDING THE FILENAME) TO THE DOCKERFILE THAT YOU WANT TO BUILD
  # DEFAULT: './Dockerfile'
  DOCKERFILE_PATH=${INPUT_DOCKERFILE_PATH:-./Dockerfile}
fi

cd $GITHUB_WORKSPACE

echo "Using $DOCKERFILE_PATH"
set +e

OUTPUT=$(/dockerfilelint/bin/dockerfilelint "$DOCKERFILE_PATH")
SUCCESS=$?
echo $OUTPUT

set -e

# If there were errors as part of linting, post a comment. Else, do nothing.
if [ $SUCCESS -ne 0 ]; then
  PAYLOAD=$(echo '{}' | jq --arg body "$OUTPUT" '.body = $body')
  COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
  curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null
else
	echo $DOCKERFILE_PATH linting exited $SUCCESS
fi

exit $SUCCESS