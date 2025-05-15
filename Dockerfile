FROM ubuntu:24.04 as builder
LABEL org.opencontainers.image.title="bch-client"
LABEL org.opencontainers.image.maintainer="contact@ikna.io"
LABEL org.opencontainers.image.url="https://www.ikna.io/"
LABEL org.opencontainers.image.description="Dockerized Bitcoin Cash client"
LABEL org.opencontainers.image.source="https://github.com/graphsense/bch-client"

ENV TZ=UTC
ADD docker/Makefile /tmp/Makefile
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        binutils \
        cmake \
        build-essential \
        ca-certificates \
        git \
        help2man \
        libboost-all-dev \
        libssl-dev \
        ninja-build \
        python3 \
        libmpfr-dev \
        libgmp-dev \
        libcurl4-openssl-dev \
        libboost-filesystem-dev \
        libboost-chrono-dev \
        libboost-test-dev \
        libboost-thread-dev \
        libevent-dev \
        libminiupnpc-dev \
        libzmq3-dev \
        libnatpmp-dev \
        zlib1g-dev \
        libdb-dev \
        libdb++-dev \
        g++ \
        wget && \
    cd /tmp && \
    make install && \
    strip /usr/local/bin/bitcoin*

FROM ubuntu:24.04

COPY --from=builder /usr/local/bin/bitcoin* /usr/local/bin/

ARG UID=10000

RUN useradd -r -u $UID dockeruser && \
    mkdir -p /opt/graphsense/data && \
    chown -R dockeruser /opt/graphsense && \
    # packages
    apt-get update && \
    apt-get install --no-install-recommends -y \
        libboost-all-dev \
        libfmt9 \
        libevent-core-2.1-7t64 \
        libevent-pthreads-2.1-7t64 \
        libminiupnpc17 \
        libssl-dev

USER dockeruser
CMD ["bitcoind", "-conf=/opt/graphsense/client.conf", "-datadir=/opt/graphsense/data", "-rest"]
