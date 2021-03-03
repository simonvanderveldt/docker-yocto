FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# From https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#required-packages-for-the-build-host
RUN apt-get update && apt-get install -y -q \
  build-essential \
  chrpath \
  cpio \
  debianutils \
  diffstat \
  gawk \
  gcc-multilib \
  git-core \
  iputils-ping \
  libegl1-mesa \
  libsdl1.2-dev \
  locales \
  pylint3 \
  python3 \
  python3-git \
  python3-jinja2 \
  python3-pexpect \
  python3-pip \
  socat \
  texinfo \
  unzip \
  wget \
  xterm \
  xz-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Ensure we're running UTF-8 locale otherwise bitbake doesn't like it
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

RUN mkdir /opt/yocto
RUN wget http://downloads.yoctoproject.org/releases/yocto/yocto-3.2.2/poky-gatesgarth-24.0.2.tar.bz2 -O /tmp/poky.tar.bz2 \
  && tar -xvf /tmp/poky.tar.bz2 -C /opt/yocto --strip-components=1

WORKDIR /opt/yocto
