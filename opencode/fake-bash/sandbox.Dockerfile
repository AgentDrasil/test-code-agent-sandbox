FROM alpine:latest

# Install common tools for the sandbox
RUN apk add --no-cache \
    bash \
    git \
    curl \
    jq \
    ripgrep \
    python3 \
    build-base

# Create user 1000:1000 to match host/main container
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

USER user
WORKDIR /home/user

CMD ["tail", "-f", "/dev/null"]
