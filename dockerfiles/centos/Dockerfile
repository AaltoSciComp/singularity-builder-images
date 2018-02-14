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
  Lmod                                    \
  openssh                                 \
  python                                  \
  python-yaml                             \
  squashfs-tools                          \
  tcl                                     \
  wget                                    \
  which                                   \
  && yum clean all

RUN mkdir /build

RUN cd /tmp && \
  VERSION=2.4.2 && \
  wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz && \
  tar xvf singularity-$VERSION.tar.gz && \
  cd singularity-$VERSION && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  rm -r /tmp/singularity*

COPY ./lmod.lmodrc.lua /etc/lmod.lmodrc.lua

COPY ./entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

RUN yum update -y                         \
  && yum upgrade -y                       \
  && yum clean all
