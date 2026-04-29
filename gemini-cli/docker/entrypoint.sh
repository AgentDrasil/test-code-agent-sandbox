#!/bin/sh

# Start Docker-in-Docker daemon with explicit DNS to avoid resolution issues
dockerd --host=unix:///var/run/docker.sock --dns 8.8.8.8 --dns 8.8.4.4 &

# Wait for Docker daemon to be ready
echo "Waiting for Docker daemon..."
timeout=30
while [ $timeout -gt 0 ]; do
  if docker info >/dev/null 2>&1; then
    echo "Docker daemon is ready."
    break
  fi
  timeout=$((timeout - 1))
  sleep 1
done

if [ $timeout -eq 0 ]; then
  echo "ERROR: Docker daemon failed to start within 30 seconds."
  exit 1
fi

# Pre-pull the sandbox image if GEMINI_SANDBOX_IMAGE is set
if [ -n "$GEMINI_SANDBOX_IMAGE" ]; then
  echo "Pre-pulling sandbox image: $GEMINI_SANDBOX_IMAGE"
  docker pull "$GEMINI_SANDBOX_IMAGE" || echo "WARNING: Failed to pre-pull sandbox image."
fi

exec su-exec user "$@"
