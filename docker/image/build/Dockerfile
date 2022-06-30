FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    bash \
    bzip2 \
    ca-certificates \
    help2man \
    libffi-dev \
    libgmp-dev \
    libssl-dev \
    libyaml-dev \
    curl \
    gnupg2 \
    git \
    libz-dev \
    nodejs \
    npm \
    pandoc \
    procps \
    ruby \
    ruby-dev \
    shellcheck \
    zip \
    zlib1g-dev \
    wget

RUN gem install bashcov ronn \
     && npm install -g bats

WORKDIR /app
