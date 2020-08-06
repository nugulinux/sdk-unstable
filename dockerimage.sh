#!/bin/bash

echo "OS=$OSTYPE"

LAST_COMMIT=`docker run -it --rm nugulinux/sdk:unstable printenv | grep LAST_COMMIT`
echo $LAST_COMMIT

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    COMMIT=$(echo $LAST_COMMIT | sed -r 's/LAST_COMMIT=(.*)/\1/' | tr -d '\r')
elif [[ "$OSTYPE" == "darwin"* ]]; then
    COMMIT=$(echo $LAST_COMMIT | gsed -r 's/LAST_COMMIT=(.*)/\1/' | tr -d '\r')
fi

echo "SHORTSHA='${SHORTSHA}'"
echo "nugulinux/sdk:unstable commit='${COMMIT}'"

if [[ "${COMMIT}" == "${SHORTSHA}" ]]; then
  echo "Same version"
  exit 0
else
  echo "not match"
  cd docker
  docker build --build-arg LAST_COMMIT=${SHORTSHA} . -t nugulinux/sdk:unstable
  cd -
fi
