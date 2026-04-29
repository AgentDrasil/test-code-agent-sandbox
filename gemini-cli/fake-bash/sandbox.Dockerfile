FROM alpine:latest

RUN apk add --no-cache \
    bash \
    ca-certificates \
    procps \
    python3 \
    && update-ca-certificates

# create user 1000:1000
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user

WORKDIR /home/user

USER user

# Run infinitely loop
CMD ["tail", "-f", "/dev/null"]
