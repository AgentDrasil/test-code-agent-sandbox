#!/bin/bash

# Run this script on host
docker compose down && docker compose up --build -d && docker exec -u user -it gemini-cli-fake-bash sh

# Then you can enter gemini-cli and ask "check python version"
