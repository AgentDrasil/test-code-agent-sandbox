#!/bin/sh

# Dynamically match the docker group GID to the mounted socket's GID
# so the non-root user can access /var/run/docker.sock
DOCKER_SOCK=/var/run/docker.sock
if [ -S "$DOCKER_SOCK" ]; then
  DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCK")
  # Check if a group with this GID already exists
  EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)
  if [ -z "$EXISTING_GROUP" ]; then
    addgroup -g "$DOCKER_GID" docker
    EXISTING_GROUP=docker
  fi
  adduser user "$EXISTING_GROUP" 2>/dev/null
  echo "Added user to group '$EXISTING_GROUP' (GID=$DOCKER_GID) for docker socket access."
else
  echo "WARNING: Docker socket not found at $DOCKER_SOCK"
fi

exec su-exec user "$@"
