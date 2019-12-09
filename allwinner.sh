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

# Fix permissions for docker
chmod 777 $PWD

cat <<EOF > sdkbuild.sh
#!/bin/zsh
set -e

mkdir -p /mnt/UDISK

rm -rf build
mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=/mnt/UDISK -DCMAKE_TOOLCHAIN_FILE=/opt/toolchain/Toolchain.cmake
make -j6
make install
mv /mnt/UDISK ./SDK
tar cvfz files_allwinner_${SHORTSHA}.tgz SDK
EOF
chmod 755 sdkbuild.sh

echo "Build crosscompile"
docker run -t --rm -v $PWD:$PWD -w $PWD \
    nugulinux/devenv:allwinner ./sdkbuild.sh

mkdir /tmp/result
cp build/files_*.tgz /tmp/result/

echo "Completed"
