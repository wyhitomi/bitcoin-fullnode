FROM debian:9

ENV BTC_VERSION 0.17
WORKDIR /usr/local/src

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
    gnupg1 \
    apt-transport-https \
    ca-certificates \
    build-essential \
    git \
    wget \
# compile and install latest bitcoin binaries
	&& git clone https://gitlab.com/alfiedotwtf/bitcoin-on-debian.git \
  && make -C bitcoin-on-debian install \
# clean-up
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# add bitcoin user
RUN useradd -m -d /bitcoin -s /bin/bash -c "Bitcoin User" -U bitcoin

# configure exposed ports
EXPOSE 8333 18333 8332 18332

# run bitcoin entrypoint
COPY bitcoin-entrypoint.sh /bitcoin-entrypoint.sh
# ENTRYPOINT /bitcoin-entrypoint.sh

# configure bitcoin home
WORKDIR /bitcoin
USER bitcoin

# start bitcoind
CMD ["bitcoind","-testnet","-txindex","-reindex"]
