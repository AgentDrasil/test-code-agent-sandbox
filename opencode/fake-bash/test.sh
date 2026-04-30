#!/bin/sh
set -e

echo "Building and starting containers..."
docker compose up -d --build

echo "Waiting for containers to be ready..."
sleep 2

echo "Testing opencode proxy..."
# We try to run a command via opencode that triggers a shell command.
# Since we don't want to actually run opencode interactively here, 
# we can just test if the bash proxy works by calling it directly or via docker exec.

echo "Verifying bash proxy location..."
docker exec opencode-fake-bash which bash

echo "Testing bash -c via proxy..."
docker exec -u user opencode-fake-bash bash -c "echo 'hello from sandbox' > /tmp/test_out && hostname"

echo "Checking if file was created in SANDBOX container..."
docker exec opencode-sandbox cat /tmp/test_out

echo "Checking if file was NOT created in MAIN container..."
if docker exec opencode-fake-bash ls /tmp/test_out 2>/dev/null; then
    echo "ERROR: File found in main container!"
    exit 1
else
    echo "SUCCESS: File not found in main container."
fi

echo "All tests passed!"
