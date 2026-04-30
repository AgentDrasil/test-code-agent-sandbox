#!/bin/bash
set -e

# Build and start the containers
docker compose up -d --build

echo "Waiting for containers to start..."
sleep 2

# Test proxying to sandbox
echo "Setup complete. You can enter the container now."
docker exec -it kilocode-fake-bash sh
