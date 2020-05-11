FROM alpine:3.11
LABEL maintainer="contact@graphsense.info"

RUN apk --no-cache add make bash boost boost-program_options libevent libressl shadow && \
    useradd -r -u 10000 dockeruser &&  \
    mkdir -p /opt/graphsense/data && \
    chown -R dockeruser /opt/graphsense

ADD docker/bitcoin.conf /opt/graphsense/bitcoin.conf
ADD docker/Makefile /tmp/Makefile

RUN apk --no-cache --virtual build-dependendencies add \
        autoconf \
        automake \
        binutils \
        boost-dev \
        cmake \
        coreutils \
        file \
        grep \
        libevent-dev \
        git \
        g++ \
        linux-headers \
        libressl-dev \
        ninja && \
    cd /tmp; make install && \
    rm -rf /tmp/src && \
    strip /usr/local/bin/*bitcoin* && \
    apk del build-dependendencies

USER dockeruser
