FROM alpine:latest
RUN apk add --no-cache ca-certificates docker-cli nodejs npm su-exec \
    && update-ca-certificates

COPY bash /bin/bash

# create user 1000:1000
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

# install gemini-cli, then remove node-pty to force child_process fallback.
# node-pty's native PTY module SEGV when bash is a shell script wrapping docker exec.
RUN npm install -g @google/gemini-cli \
    && rm -rf /usr/local/lib/node_modules/@google/gemini-cli/node_modules/@lydell/

# Alternative: if you don't want to modify the installation of gemini-cli, 
# we can use setting to disable interactive shell, by adding ~/.gemini/settings.json:
# {  
#   "tools": {  
#     "shell": {  
#       "enableInteractiveShell": false  
#     }  
#   }  
# }

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Run infinitely loop
CMD ["tail", "-f", "/dev/null"]
