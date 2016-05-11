FROM ubuntu:latest

MAINTAINER Cameron Mullen <cam@skio.io>

RUN \
  apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y \
    oracle-java8-installer \
    git

# Installing JRUBY
ENV JRUBY_VERSION=9.1.0.0
RUN \
  wget https://s3.amazonaws.com/jruby.org/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz && \
  tar -xf jruby-bin-$JRUBY_VERSION.tar.gz && \
  rm jruby-bin-$JRUBY_VERSION.tar.gz && \
  mv jruby-$JRUBY_VERSION /jruby && \
  /jruby/bin/jruby -S gem install bundler jbundler rake ruby-maven-libs --no-document

ENV PATH=/jruby/bin:$PATH
