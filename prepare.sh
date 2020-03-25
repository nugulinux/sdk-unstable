#!/bin/bash
set -e

echo "Repository slug = ${REPOSLUG}"
echo "SHA = ${SHA}"
echo "Short SHA = ${SHORTSHA}"

# Get date for commit to genereate version
DATETIME=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X GET https://api.github.com/repos/${REPOSLUG}/commits/${SHORTSHA} | jq '.commit.committer.date' -r)
echo "commit.committer.date = ${DATETIME}"

STAMP=$(date -d ${DATETIME} +%Y%m%d)
VERSION="${STAMP}${SHORTSHA}"
echo "package version = ${VERSION}"

echo "Clone the sdk repository"
git clone https://github.com/${REPOSLUG} --recursive
cd ${REPO}
git checkout ${SHA}
git reset --hard
rm -rf .git

echo "Add commit-id(${SHORTSHA}) to package version"
sed -i "1 s/ubuntu[0-9]*~xenial/ubuntu${VERSION}~xenial/" packaging/xenial/changelog
sed -i "1 s/ubuntu[0-9]*~bionic/ubuntu${VERSION}~bionic/" packaging/bionic/changelog
head -1 packaging/xenial/changelog
head -1 packaging/bionic/changelog
cd -

# Fix permissions for docker
chmod 777 $PWD
chmod 777 $PWD/${REPO}

echo "Build debian package"
docker run -t --rm --privileged -v $PWD:$PWD -w $PWD/${REPO} \
    -v /var/lib/schroot/chroots \
    nugulinux/buildenv:$TARGET sdkbuild.sh

ls -l

if [[ -d /tmp/result ]]; then
	echo "/tmp/result exist"
	ls -l /tmp/result
	rm -rf /tmp/result/*
else
	echo "Create /tmp/result"
	mkdir /tmp/result
fi

cp *.deb /tmp/result/

echo "Completed"
