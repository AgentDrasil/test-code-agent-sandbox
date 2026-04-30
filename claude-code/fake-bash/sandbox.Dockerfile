FROM alpine:latest

RUN apk add --no-cache bash git curl jq ripgrep python3

# Create user 1000:1000 to match host/main container
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

# Create necessary directories for Claude Code snapshots
RUN mkdir -p /home/user/.claude/shell-snapshots && \
    chown -R user:user /home/user/.claude

USER user
WORKDIR /home/user

CMD ["tail", "-f", "/dev/null"]
