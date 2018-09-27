#!/bin/bash

[[ -f /opt/local/etc/bash_completion ]] && . /opt/local/etc/bash_completion

export SREGISTRY_DATABASE=/singularity/baseimages/sregistry.db
export SREGISTRY_STORAGE=/singularity/baseimages/cache
export SINGULARITY_CACHEDIR=/singularity/cache
export SINGULARITY_TMPDIR=/singularity/cache/tmp

for ARG in "$@"
do
case $ARG in 
  build)
    cd /build
    shift
    python -u install.py "$@"
    exit $?
    ;;
  lmod)
    [[ -f /usr/share/lmod/5.8/init/bash ]] && . /usr/share/lmod/5.8/init/bash
    shift
    exec "$@"
    exit $?
    ;;
  *)
    cd /build
    exec "$@"
    exit $?
    ;;
esac
done
