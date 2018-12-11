#!/usr/bin/env bash

BITCOIN_HOME="/bitcoin/.bitcoin"

set -e

if [ -z ${RPCUSER+x} ]; then echo "USER is unset, using default";export RPCUSER='bitcoin'; else echo "USER is set to '$USER'"; fi
if [ -z ${RPCPASSWORD+x} ]; then echo "RPCPASSWORD is unset, using default"; export RPCPASSWORD='changeme'; else echo "RPCPASSWORD is set to '$RPCPASSWORD'"; fi

if [[ -f "$BITCOIN_HOME/bitcoin.conf" ]]; then
  rm -f $BITCOIN_HOME/bitcoin.conf
fi

echo "# Bitcoin Config" | tee $BITCOIN_HOME/bitcoin.conf
echo "# Version: $BTC_VERSION" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "#----" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "logtimestamps=1" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "maxconnections=512" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "testnet=1" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "#----" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "rpcuser=$RPCUSER" | tee -a $BITCOIN_HOME/bitcoin.conf
echo "rpcpassword=$RPCPASSWORD" | tee -a $BITCOIN_HOME/bitcoin.conf


exec "$@"
