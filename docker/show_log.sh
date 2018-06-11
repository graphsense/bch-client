#!/bin/sh

docker exec bitcoin-cash bash -c "tail -f /opt/graphsense/data/debug.log"
