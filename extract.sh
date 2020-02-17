#!/bin/bash

if [[ ! -z $1 ]]; then
    FILENAME=$1
else
    FILENAME=files
fi

echo "Output name = ${FILENAME}.tgz"

# Create temporary directory
if [[ ! -d dest ]]; then
    mkdir dest
fi

# Extract all deb packages
FILES=$(ls *.deb)
for item in $FILES
do
    echo "Extract ${item}"
    ar x ${item}
    tar -C dest -xvf data.tar.xz
done

# Generate files.tgz
cd dest
tar cvfz ../${FILENAME}.tgz .
cd -

cp ${FILENAME}.tgz /tmp/result/

# Remove temporary directory
rm -rf dest

echo "Cleanup workspace"
git reset --hard
git clean -dfx

