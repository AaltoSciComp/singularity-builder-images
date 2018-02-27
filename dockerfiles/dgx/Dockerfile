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
  tcl                                     \
  wget                                    \
  which                                   \
  && yum clean all

RUN yum update -y && yum install -y       \
  python-jinja2                           \
  squashfs-tools                          \
  && yum clean all

RUN mkdir /build

ARG COMMIT=da434579e6f8956428f92e7efa1803d421416b55
ARG BRANCH=origin/nvcr-io-registry-fixes

RUN cd /tmp && \
  git clone https://github.com/jtriley/singularity.git && \
  cd singularity && \
  git branch "$BRANCH" && \
  git checkout "$COMMIT" && \
  ./autogen.sh && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  rm -r /tmp/singularity*

RUN mkdir /singularity

COPY ./lmod.lmodrc.lua /etc/lmod.lmodrc.lua

COPY ./entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

RUN yum update -y                         \
  && yum upgrade -y                       \
  && yum clean all
