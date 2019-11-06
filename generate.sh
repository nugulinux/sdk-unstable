#!/bin/bash

REPOSLUG=${TRAVIS_REPO_SLUG}
TAG=${SHORTSHA}

BASEROOT=/tmp/www
POOL_XENIAL=${BASEROOT}/ubuntu/dists/xenial/pool
POOL_BIONIC=${BASEROOT}/ubuntu/dists/bionic/pool

DIRS=(
    ${POOL_XENIAL}
    ${POOL_BIONIC}
    ${BASEROOT}/ubuntu/dists/xenial/main/binary-amd64
    ${BASEROOT}/ubuntu/dists/xenial/main/binary-arm64
    ${BASEROOT}/ubuntu/dists/xenial/main/binary-armhf
    ${BASEROOT}/ubuntu/dists/bionic/main/binary-amd64
    ${BASEROOT}/ubuntu/dists/bionic/main/binary-arm64
    ${BASEROOT}/ubuntu/dists/bionic/main/binary-armhf
)

for item in "${DIRS[@]}"
do
    echo "- Create ${item}"
    if [[ ! -d ${item} ]]; then
        mkdir -p ${item}
    fi
done

echo "Get release(${TAG}) information from ${REPOSLUG}"

ID=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X GET https://api.github.com/repos/${REPOSLUG}/releases/tags/${TAG} | jq '.id' -r)
echo "ID = ${ID}"

echo "Get file list"
RESULT=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" -X GET https://api.github.com/repos/${REPOSLUG}/releases/${ID}/assets?per_page=50)
FILES=$(echo $RESULT  | jq '.[].browser_download_url' -r)
for item in $FILES
do
    if [[ $item != *.deb ]]; then
        echo "- ignore: ${item}"
        continue
    fi

    if [[ $item == *"xenial"* ]]; then
        echo "- 16.04: ${item}"
        wget -nv ${item} -P ${POOL_XENIAL}
    elif [[ $item == *"bionic"* ]]; then
        echo "- 18.04: ${item}"
        wget -nv ${item} -P ${POOL_BIONIC}
    else
        echo "- unknown version: ${item}"
    fi
done

# Generate index.html
DATE=$(date)
cat <<EOF > ${BASEROOT}/index.html
<html>
<body>
<h1>DEB Package repository for unstable release</h1>
last unstable commit: <a href="https://github.com/nugu-developers/nugu-linux/commit/${SHORTSHA}">${SHORTSHA}</a>

<hr/>

<h2>NUGU SDK for Linux PPA Setup (stable release)</h2>
<pre>
    add-apt-repository ppa:nugulinux/sdk
    apt-get update
</pre>

<hr/>

<h2>Unstable package repository setup</h2>

<h3>Bionic (18.04)</h3>
<pre>
    echo "deb [trusted=yes] https://nugulinux.github.io/sdk-unstable/ubuntu/ bionic main" > /etc/apt/sources.list.d/nugudev.list
    apt-get update
</pre>

<h3>Xenial (16.04)</h3>
<pre>
    echo "deb [trusted=yes] https://nugulinux.github.io/sdk-unstable/ubuntu/ xenial main" > /etc/apt/sources.list.d/nugudev.list
    apt-get update
</pre>

<hr/>

<p>Generated at ${DATE}</p>

</body>
</html>
EOF

function generate {
    DIST=$1
    HOST=$2
    REPO="dists/$DIST/pool"
    PKGS="dists/$DIST/main/binary-$HOST/"

    echo "DEB Repo: $REPO"
    echo "Packages path: $PKGS"

    cd ${BASEROOT}/ubuntu
    dpkg-scanpackages -m -a $HOST $REPO > $PKGS/Packages
    cd -
}

generate "xenial" "amd64"
generate "xenial" "arm64"
generate "xenial" "armhf"
generate "bionic" "amd64"
generate "bionic" "arm64"
generate "bionic" "armhf"
