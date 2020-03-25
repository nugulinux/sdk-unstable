[![Build Status](https://travis-ci.org/nugulinux/sdk-unstable.svg?branch=master)](https://travis-ci.org/nugulinux/sdk-unstable)

# NUGU SDK for Linux unstable repository

Unstable release page: <https://nugulinux.github.io/sdk-unstable/>

Unstable API document: <https://nugulinux.github.io/sdk-unstable/doxygen/>

## Usage

Add NUGU SDK for Linux PPA:

    sudo add-apt-repository ppa:nugulinux/sdk

Create a `/etc/apt/sources.list.d/nugu-unstable.list` file with following content.

Ubuntu 16.04:

    deb [trusted=yes] https://nugulinux.github.io/sdk-unstable/ubuntu/ xenial main

Ubuntu 18.04:

    deb [trusted=yes] https://nugulinux.github.io/sdk-unstable/ubuntu/ bionic main

Update the package information

    sudo apt-get update
