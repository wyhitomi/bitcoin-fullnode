#!/usr/bin/env bash

if [[ -f "docker-compose.yml" ]]; then
  docker-compose up
else
  docker run -it --name bitcoin-testnet -p 18333:18333 -p 18332:18332 -v $PWD/bitcoin_home:/bitcoin/.bitcoin wyhitomi/bitcoin:0.17-stretch
fi
