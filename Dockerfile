FROM ubuntu:20.04 as builder
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
        wget && \
    cd /tmp && \
    make install && \
    strip /usr/local/bin/bitcoin*

FROM ubuntu:20.04

COPY --from=builder /usr/local/bin/bitcoin* /usr/local/bin/

ARG UID=10000

RUN useradd -r -u $UID dockeruser && \
    mkdir -p /opt/graphsense/data && \
    chown -R dockeruser /opt/graphsense && \
    # packages
    apt-get update && \
    apt-get install --no-install-recommends -y \
        libboost-chrono1.71.0 \
        libboost-filesystem1.71.0 \
        libboost-program-options1.71.0 \
        libboost-system1.71.0 \
        libboost-thread1.71.0 \
        libevent-2.1-7 \
        libevent-pthreads-2.1-7 \
        libminiupnpc17 \
        libssl1.1

USER dockeruser
CMD ["bitcoind", "-conf=/opt/graphsense/client.conf", "-datadir=/opt/graphsense/data", "-rest"]
