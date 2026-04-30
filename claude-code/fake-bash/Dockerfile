FROM alpine:latest

# Install dependencies
RUN apk add --no-cache wget ca-certificates git ripgrep docker-cli su-exec \
    && update-ca-certificates

# Add Claude Code repository and key
RUN wget -O /etc/apk/keys/claude-code.rsa.pub \
    https://downloads.claude.ai/keys/claude-code.rsa.pub && \
    echo "https://downloads.claude.ai/claude-code/apk/stable" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache claude-code

# Create user 1000:1000
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

# Copy fake bash and entrypoint
COPY bash /bin/bash
COPY entrypoint.sh /entrypoint.sh

WORKDIR /home/user

ENTRYPOINT ["/entrypoint.sh"]

# Run infinitely loop
CMD ["tail", "-f", "/dev/null"]
