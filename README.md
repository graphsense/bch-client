# Bitcoin Cash Docker container

A Docker container running [Bitcoin ABC][bitcoin-abc] as a service and
exposing the REST API. Bitcoin ABC is a full node implementation of the
Bitcoin Cash protocol.

## Prerequisites

- [Docker][docker], see e.g. https://docs.docker.com/engine/install/
- Docker Compose: https://docs.docker.com/compose/install/

Ensure that a user `dockeruser` with ID `10000` exists on your local system.

## Configuration

Modify `docker/bitcoin.conf` according to your environment
(see [doc][bitcoin-conf]).

Configure `rpcallowip=...` to allow the client/daemon to accept
RPC connections outside the localhost and set an RPC username (`rpcuser`)
and password (`rpcpassword`).

Make sure your config file includes the following line:

    txindex=1

Client data is persisted on the host machine using a Docker volume.
In the default setting the local directory `./data` is mapped to
to `/opt/graphsense/data` inside the container. To override these
settings a Docker Compose override file can be used, e.g.

```
> cat docker-compose.override.yml
version: "3.1"

services:
  bitcoin-cash-client:
    volumes:
      - /var/data/graphsense/clients/bch:/opt/graphsense/data
```

The data directory on the host system must be writeable by user `dockeruser`.

## Usage

Building the docker container (a tagged GitHub version of Bitcoin Cash is
specified in `docker/Makefile`):

    docker-compose build

Starting the container (in detached mode):

    docker-compose up -d

Showing log information:

    docker-compose logs


[bitcoin-abc]: https://www.bitcoinabc.org
[docker]: https://www.docker.com
[bitcoin-conf]: https://en.bitcoin.it/wiki/Running_Bitcoin#Bitcoin.conf_Configuration_File
