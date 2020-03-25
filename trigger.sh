#!/bin/bash

if [ $# != 3 ]; then
    echo "Usage: $0 {repo_owner} {repo_name} {branch}"
    exit 1
fi

TRAVIS_ACCESS_TOKEN=zVfGbxmw0I_zz4EAXvbDZA
REPO_OWNER=$1
REPO_NAME=$2
BRANCH=$3

echo "> Travis trigger REPO = ${REPO_OWNER}/${REPO_NAME}"
echo "> Travis trigger BRANCH = ${BRANCH}"

jq -n --arg branch "${BRANCH}" \
    '{ "request": { "branch": $branch } }' | curl -s -D - \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Travis-API-Version: 3" \
    -H "Authorization: token ${TRAVIS_ACCESS_TOKEN}" \
    -X POST https://api.travis-ci.org/repo/${REPO_OWNER}%2F${REPO_NAME}/requests -d@-

echo
echo "> Travis trigger completed (${REPO_OWNER}/${REPO_NAME} ${BRANCH})"
