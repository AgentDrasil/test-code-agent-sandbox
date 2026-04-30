FROM alpine:latest
RUN apk add --no-cache bash ca-certificates nodejs npm \
    && update-ca-certificates

# create user 1000:1000
RUN addgroup -g 1000 user && adduser -u 1000 -G user -s /bin/sh -D user


# install gemini-cli
RUN npm install -g @google/gemini-cli

USER user

# Run infinitely loop
CMD ["tail", "-f", "/dev/null"]
