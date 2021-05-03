FROM ubuntu:20.04 as builder
LABEL maintainer="contact@graphsense.info"

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

RUN useradd -r -u 10000 dockeruser && \
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

ADD docker/bitcoin.conf /opt/graphsense/bitcoin.conf

USER dockeruser
CMD ["bitcoind", "-conf=/opt/graphsense/bitcoin.conf", "-datadir=/opt/graphsense/data", "-rest"]
