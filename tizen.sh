#!/bin/bash
set -e

echo "> Repository slug = ${REPOSLUG}"
echo "> SHA = ${SHA}"
echo "> Short SHA = ${SHORTSHA}"

echo "> Clone the repository"
git clone https://github.com/${REPOSLUG} --recursive
cd ${REPO}
git checkout ${SHA}
git reset --hard
rm -rf .git

# Fix permissions for docker
chmod 777 $PWD -R

SDKPATH=$PWD/SDK
echo "> SDK Install PATH=$SDKPATH"

cat <<EOF > sdkbuild.sh
#!/bin/bash
set -e
set -x

source ~/${TARGET}.env

echo $PWD

rm -rf SDK
mkdir SDK

rm -rf build
mkdir build

cd build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=/ \
    -DCMAKE_TOOLCHAIN_FILE=~/Toolchain.cmake \
    -DENABLE_LOG_ANSICOLOR=OFF \
    -DENABLE_OPUS_PLUGIN=ON \
    -DENABLE_GSTREAMER_PLUGIN=OFF \
    -DENABLE_PORTAUDIO_PLUGIN=OFF \
    -DENABLE_VENDOR_LIBRARY=ON \
    -DENABLE_OPUS_LIBRARY=ON

make -j6

DESTDIR=$SDKPATH make install

cd ..
tar cvfz files_tizen_${TARGET}_${SHORTSHA}.tgz SDK
EOF

chmod 755 sdkbuild.sh

echo "> Build ${TARGET}"
docker run -t --rm -v $PWD:$PWD -w $PWD \
    nugulinux/devenv:tizen ./sdkbuild.sh

mkdir /tmp/result
cp files_*.tgz /tmp/result/

cd ..
whoami
ls -l

sudo rm -rf ${REPO}

echo "> Completed"
