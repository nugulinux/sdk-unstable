#!/bin/bash
set -e

if [ $# != 1 ]; then
    echo "Usage: $0 {flag-file-name}"
    exit 1
fi

echo "> output flag file: $1"

echo "> TARGET = allwinner"
echo "> SHA = ${SHA}"
echo "> SHORTSHA = ${SHORTSHA}"
echo "> TRAVIS_REPO_SLUG = ${TRAVIS_REPO_SLUG}"
echo "> CURL_AUTH = ${CURL_AUTH}"

# Check for releases
ID=$(curl -s -H "$CURL_AUTH" -X GET https://api.github.com/repos/${TRAVIS_REPO_SLUG}/releases/tags/${SHORTSHA} | jq '.id' -r)
echo "> Release ID = ${ID}"
if [[ ${ID} == "null" ]]; then
    echo "Release ${ID} not exist."
    exit
fi

# Check for duplicated files
COUNT=0
MATCH_COUNT=1
RESULT=$(curl -s -H "$CURL_AUTH" -X GET https://api.github.com/repos/${TRAVIS_REPO_SLUG}/releases/${ID}/assets?per_page=50)
FILES=$(echo $RESULT  | jq '.[].name' -r)

for item in $FILES
do
    # Check ARCH or ARCH2
    if [[ $item == *"allwinner"* ]]; then
        :
    else
        continue;
    fi

    declare -i COUNT; COUNT+=1
    echo "> Found build artifacts: [${COUNT}/${MATCH_COUNT}] ${item}"
done

# Mark to flag file to trigger the build
if [[ $COUNT == $MATCH_COUNT ]]; then
    echo "> There is no need to rebuild."
else
    echo "> Rebuild required"
    echo 1 > $1
fi

echo "> Check completed"
