#!/bin/sh
if [ -e /var/run/docker.sock ]; then
  DOCKER_GID=$(stat -c "%g" /var/run/docker.sock)
  GROUP_NAME=$(grep ":$DOCKER_GID:" /etc/group | cut -d: -f1)
  if [ -z "$GROUP_NAME" ]; then
    GROUP_NAME=docker_host
    addgroup -g $DOCKER_GID $GROUP_NAME
  fi
  adduser user $GROUP_NAME
fi
exec su-exec user "$@"
