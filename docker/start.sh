#!/bin/sh

if ! [ -n "$1" ] ; then
    echo "Please provide directory for blockchain data."
    exit 1
fi

docker stop bitcoin-cash
docker rm bitcoin-cash

chown -R dockeruser "$1"

docker run --restart=always -d --name bitcoin-cash \
    --cap-drop all \
    -p 8432:8432 \
    -v "$1":/opt/graphsense/data \
    -it bitcoin-cash
docker ps -a
