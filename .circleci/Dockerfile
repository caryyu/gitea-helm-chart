FROM alpine:3.8

RUN apk update && apk add --no-cache \
  bash \
  bc \
  coreutils \
  curl \
  gawk \
  git \
  gnupg \
  grep \
  jq \
  openssl \
  openssh \
  py-pip \
  sed \
  unzip \
  vim \
  nodejs \
  npm 

WORKDIR /app/
COPY scripts/* /app/scripts/
RUN /bin/bash scripts/bootstrap
RUN helm init --client-only