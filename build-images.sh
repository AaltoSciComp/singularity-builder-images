#!/bin/bash

PUSH=1

for ARG in "$@"
do
case $ARG in 
  -p|--push)
  PUSH=0
  shift
  ;;
  *)
  echo 'Unknown argument "'$ARG'". Quitting.'
  exit 1
  ;;
esac
done

for OSFOLDER in $(ls -d dockerfiles/*); do
  OS=$(basename $OSFOLDER)
  if [ -f $OSFOLDER/Dockerfile ]; then
    BUILD_RESULT=1
    docker build -t aaltoscienceit/singularity-builder-images:$OS $OSFOLDER
    BUILD_RESULT=$?
    if [ $PUSH -eq 0 ] && [ $BUILD_RESULT -eq 0 ]; then
      docker push aaltoscienceit/singularity-builder-images:$OS
    else
      echo 'Build for "'$OS'" failed, will not push'
    fi
  fi
done

