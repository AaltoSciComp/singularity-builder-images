FROM centos:centos7

RUN yum install -y epel-release           \
  && yum update -y                        \
  && yum clean all

RUN yum groups mark install "Development Tools" \
  && yum groups mark convert "Development Tools" \
  && yum groupinstall -y "Development Tools" \
  && yum clean all

RUN yum update -y && yum install -y       \
  bash-completion                         \
  cmake                                   \
  curl                                    \
  git                                     \
  libarchive-devel                        \
  libuuid-devel                           \
  Lmod                                    \
  openssh                                 \
  openssl-devel                           \
  python                                  \
  python-yaml                             \
  python-pip                              \
  tcl                                     \
  wget                                    \
  which                                   \
  && yum clean all

RUN yum update -y && yum install -y       \
  python-jinja2                           \
  squashfs-tools                          \
  && yum clean all

RUN mkdir /build

ARG RELEASE=2.6.0

RUN cd /tmp && \
  wget https://github.com/sylabs/singularity/releases/download/$RELEASE/singularity-$RELEASE.tar.gz && \
  tar xvf singularity-$RELEASE.tar.gz && \
  cd singularity-$RELEASE && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  rm -r /tmp/singularity*

RUN mkdir /singularity

RUN yum update -y && yum install -y       \
  sudo                                    \
  && yum clean all

ARG WORKER_UID=1000

RUN groupadd -g $WORKER_UID buildbot && \
    useradd -m -s /bin/bash -u $WORKER_UID -g $WORKER_UID buildbot && \
    gpasswd -a buildbot wheel && \
    chown -Rh $WORKER_UID:$WORKER_UID /home/buildbot

COPY ./lmod.lmodrc.lua /etc/lmod.lmodrc.lua

COPY ./entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

RUN yum update -y                         \
  && yum upgrade -y                       \
  && yum clean all
