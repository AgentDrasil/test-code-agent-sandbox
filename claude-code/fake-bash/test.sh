#!/bin/bash

# Run this script on host to test the setup
docker compose down && docker compose up --build -d && docker exec -u user -it claude-code-fake-bash sh

# Inside the shell, you can check if bash is the proxy script:
# cat /bin/bash
# 
# Then you can try running a command that should execute in the sandbox:
# bash -c "touch /tmp/hello_from_main && ls /tmp"
#
# Then check the sandbox container to see if the file exists:
# docker exec claude-code-sandbox ls /tmp
