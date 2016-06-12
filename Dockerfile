FROM ubuntu:xenial

MAINTAINER Cameron Mullen <cam@skio.io>

ENV JRUBY_VERSION=9.1.2.0 \
    JRUBY_SHA256=60598a465883ab4c933f805de4a7f280052bddc793b95735465619c03ca43f35

# Install base utilities
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    openjdk-8-jdk-headless \
    wget \
    ca-certificates && \
  rm -rf /var/lib/apt/lists/*

# Installing JRUBY
RUN \
  mkdir -p /usr/local/etc && \
  { echo 'install: --no-document'; echo 'update: --no-document'; } >> /usr/local/etc/gemrc && \
  wget -O jruby.tar.gz https://s3.amazonaws.com/jruby.org/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz && \
  echo "$JRUBY_SHA256 *jruby.tar.gz" | sha256sum -c - && \
  mkdir -p /opt/jruby && \
  tar -xzf jruby.tar.gz --strip-components=1 -C /opt/jruby && \
  rm jruby.tar.gz && \
  update-alternatives --install /usr/local/bin/ruby ruby /opt/jruby/bin/jruby 1

ENV PATH=$PATH:/opt/jruby/bin

RUN JRUBY_OPTS=--dev gem install bundler

ENV GEM_HOME=/usr/local/bundle

ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME"

ENV PATH=$PATH:$BUNDLE_BIN

RUN \
  mkdir -p "$GEM_HOME" "$BUNDLE_BIN" && \
  chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

CMD ["irb"]
