FROM ubuntu:xenial

RUN apt-get update && apt-get install -y  \
  openssh-client                          \ 
  wget                                    \
  curl                                    \
  git                                     \
  build-essential                         \
  cmake                                   \
  g++                                     \
  python                                  \
  python-yaml                             \
  lmod                                    \
  tcl                                     \
  bash-completion                         \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /build

COPY ./lmod.lmodrc.lua /etc/lmod.lmodrc.lua

COPY ./entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

RUN apt-get update && \
  apt-get dist-upgrade -y \
  && rm -rf /var/lib/apt/lists/*
