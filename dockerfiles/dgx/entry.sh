#!/bin/bash

[[ -f /opt/local/etc/bash_completion ]] && . /opt/local/etc/bash_completion

export SREGISTRY_DATABASE=/singularity/baseimages/sregistry.db
export SREGISTRY_STORAGE=/singularity/baseimages/cache
export SINGULARITY_CACHEDIR=/singularity/cache
export SINGULARITY_TMPDIR=/singularity/cache/tmp

if [[ "$#" -eq 0 ]]; then 
  cd /build
  python -u install.py
  exit $?
elif [[ "$1" == "lmod" ]]; then
  [[ -f /usr/share/lmod/5.8/init/bash ]] && . /usr/share/lmod/5.8/init/bash
  exec "${@:2}"
elif [[ "$1" == "build" ]]; then
  cd /build
  python -u install.py ${@:2}
  exit $?
else
  cd /build
  exec "$@"
fi
