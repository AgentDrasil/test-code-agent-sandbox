FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    ca-certificates \
    nodejs \
    npm \
    docker-cli \
    su-exec \
    shadow \
    gcompat \
    libc6-compat \
    && update-ca-certificates

# Create user 1000:1000
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

# Install kilocode-cli
RUN npm install -g @kilocode/cli

# Set up fake bash
COPY bash /usr/local/bin/bash

# Pre-create kilocode directories with correct permissions
RUN mkdir -p /home/user/.local/state && \
    mkdir -p /home/user/.local/share/kilo && \
    mkdir -p /home/user/.config/kilo && \
    chown -R user:user /home/user/.local /home/user/.config

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /home/user

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]
