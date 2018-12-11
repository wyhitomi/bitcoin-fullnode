#!/usr/bin/env bash

if [[ ! -d "$PWD/bitcoin_home" && $(docker ps -a | grep bitcoin-testnet) ]]; then
  (set -x;docker rm -f bitcoin-testnet)
fi

if [[ -f "docker-compose.yml" ]]; then
  docker-compose up -d
  docker-compose logs -f
else
  docker run -d --name bitcoin-testnet -p 18333:18333 -p 18332:18332 -v $PWD/bitcoin_home:/bitcoin/.bitcoin wyhitomi/bitcoin:0.17-bionic
  docker logs -f --tail=200 bitcoin-testnet
fi
