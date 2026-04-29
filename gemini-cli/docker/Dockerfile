FROM alpine:latest
RUN apk add --no-cache bash ca-certificates nodejs npm docker su-exec \
    && update-ca-certificates

# create user 1000:1000, add to docker group
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/bash -D user \
    && adduser user docker

# install gemini-cli
RUN npm install -g @google/gemini-cli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Run infinitely loop
CMD ["tail", "-f", "/dev/null"]
