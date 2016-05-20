FROM frolvlad/alpine-oraclejdk8

MAINTAINER Cameron Mullen <cam@skio.io>

# Install base utilities
RUN \
  apk update && \
  apk upgrade && \
  apk add --no-cache \
    wget \
    git \
    tar \
    bash

# Installing JRUBY
ENV JRUBY_VERSION=9.1.0.0
RUN \
  wget https://s3.amazonaws.com/jruby.org/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz && \
  tar -xf jruby-bin-$JRUBY_VERSION.tar.gz && \
  rm jruby-bin-$JRUBY_VERSION.tar.gz && \
  mv jruby-$JRUBY_VERSION /jruby && \
  /jruby/bin/jruby -S gem install bundler --no-document

ENV PATH=/jruby/bin:$PATH
