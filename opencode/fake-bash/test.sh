#!/bin/sh
set -e

echo "Building and starting containers..."
docker compose up -d --build

echo "Waiting for containers to be ready..."
sleep 2

# Test proxying to sandbox
echo "Setup complete. You can enter the container now."
docker exec -it opencode-fake-bash sh
