FROM ubuntu:bionic
LABEL maintainer="nugulinux@gmail.com" \
      version="0.1" \
      description="nugulinux unstable sdk"

ARG LAST_COMMIT

ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C \
    LANG=C \
    LANGUAGE=C \
    SHELL=/bin/bash \
    PULSE_SERVER=host.docker.internal \
    LAST_COMMIT=$LAST_COMMIT

RUN apt-get update && apt-get install -y software-properties-common ca-certificates --no-install-recommends \
    && add-apt-repository -y ppa:nugulinux/sdk \
    && echo "deb [trusted=yes] https://nugulinux.github.io/sdk-unstable/ubuntu/ bionic main" > /etc/apt/sources.list.d/nugu-unstable.list \
    && apt-get update && apt-get install -y --no-install-recommends \
    gstreamer1.0-pulseaudio \
    libnugu \
    libnugu-plugins-default \
    libnugu-examples \
    pulseaudio \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/lib/nugu
