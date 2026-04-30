FROM alpine:latest
RUN apk add --no-cache bash ca-certificates nodejs npm gcompat libc6-compat \
    && update-ca-certificates

# create user 1000:1000
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

# install opencode-ai
RUN npm install -g opencode-ai

USER user
WORKDIR /home/user
RUN mkdir -p /home/user/.local/state && \
    mkdir -p /home/user/.local/share/opencode

# Run infinitely loop
CMD ["tail", "-f", "/dev/null"]
