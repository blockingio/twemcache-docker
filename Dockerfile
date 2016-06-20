FROM debian:jessie
MAINTAINER Rahul Batra <rahul.batra@gmail.com>

RUN apt-get update \
    && apt-get install -y \
        git \
        autoconf automake libtool make \
        libevent-dev \
    && cd /tmp/ \
    && git clone https://github.com/twitter/twemcache.git \
    && cd twemcache \
    && git checkout v2.6.2 \
    && autoreconf --install \
    && autoconf configure.ac > configure \
    && chmod +x configure \
    && ./configure \
    && make \
    && make install \
    && groupadd twemcache \
    && useradd twemcache -g twemcache \
    && cd ..\
    && apt-get clean \
    && rm -rf /tmp/twemcache

EXPOSE 11211
CMD ["twemcache", "-u", "twemcache"]
