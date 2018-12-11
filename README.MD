# Bitcoin v0.17 Fullnode@testnet3

## Running
Running using docker daemon
```
docker pull wyhitomi/bitcoin:0.17-bionic
docker run -it --name bitcoin-testnet -p 18333:18333 -p 18332:18332 -v $PWD/bitcoin_home:/bitcoin/.bitcoin wyhitomi/bitcoin:0.17-bionic
```

Running with running script
```
./docker_run.sh
```

Running with docker-compose
```
cp docker-compose.example.yml docker-compose.yml
```
