#!/bin/bash
#set -e

echo "Repository slug = ${REPOSLUG}"
echo "SHA = ${SHA}"
echo "Short SHA = ${SHORTSHA}"

echo "Clone the repository"
git clone https://github.com/${REPOSLUG} --recursive
cd ${REPO}
git checkout ${SHA}
git reset --hard
rm -rf .git

echo "Add commit-id(${SHORTSHA}) to package version"
sed -i "1 s/ubuntu[0-9]*~xenial/ubuntu${SHORTSHA}~xenial/" packaging/xenial/changelog
sed -i "1 s/ubuntu[0-9]*~bionic/ubuntu${SHORTSHA}~bionic/" packaging/bionic/changelog
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
mkdir /tmp/result
cp *.deb /tmp/result/

echo "Completed"
