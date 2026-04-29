FROM alpine:latest

RUN apk add --no-cache \
    bash \
    bc \
    ca-certificates \
    curl \
    bind-tools \
    gh \
    git \
    jq \
    less \
    lsof \
    nodejs \
    npm \
    procps \
    psmisc \
    python3 \
    ripgrep \
    rsync \
    socat \
    unzip \
    && update-ca-certificates

# install gemini-cli
RUN npm install -g @google/gemini-cli
