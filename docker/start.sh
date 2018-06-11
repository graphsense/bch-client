#!/bin/sh

if ! [ -n "$1" ] ; then
    echo "Please provide directory for blockchain data."
fi

docker stop bitcoin-cash
docker rm bitcoin-cash

chown -R dockeruser "$1"

docker run --restart=always -d --name bitcoin-cash \
    -p 8432:8432 \
    -v "$1":/opt/graphsense/data \
    -it bitcoin-cash
docker ps -a
