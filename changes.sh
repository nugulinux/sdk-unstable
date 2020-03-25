#!/bin/bash
set -e

if [ $# != 1 ]; then
    echo "Usage: $0 {flag-file-name}"
    exit 1
fi

echo "> output flag file: $1"

echo "> TRAVIS_ACCESS_TOKEN: $TRAVIS_ACCESS_TOKEN"

# Check for duplicate releases
ID=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X GET https://api.github.com/repos/${TRAVIS_REPO_SLUG}/releases/tags/${SHORTSHA} | jq '.id' -r)
echo "> Release ID = ${ID}"
if [[ ${ID} != "null" ]]; then
    echo "Skip deploy to release ${ID}"
    exit
fi

# Get commit message
MSG=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X GET https://api.github.com/repos/${REPOSLUG}/commits/master | jq '.commit.message' -r)

# Create new release
jq -n --arg body "${MSG}" \
    --arg tag_name "${SHORTSHA}" \
    --arg name "${SHORTSHA}" \
    '{ "tag_name": $tag_name, "name": $name, "body": $body }' | curl -D - \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -X POST https://api.github.com/repos/${TRAVIS_REPO_SLUG}/releases -d@-

# Get commit history from latest official release tag
git clone https://github.com/${REPOSLUG}
cd ${REPO}
git checkout ${SHA}
git reset --hard
git log $(git describe --tags --abbrev=0)..HEAD --oneline > $1
cd -
rm -rf ${REPO}
