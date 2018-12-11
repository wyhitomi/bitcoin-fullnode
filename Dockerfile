FROM ubuntu:bionic

ENV BTC_VERSION 0.17
ENV TZ 'America/Sao_Paulo'

RUN set -x \
# Setting Brazillian Timezone
  && echo $TZ > /etc/timezone \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata \
  && rm /etc/localtime \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata \
# uninstall tzdata, locales
  && apt-get purge -y tzdata locales \
# Add bitcoin user
  && useradd -m -d /bitcoin -s /bin/bash -c "Bitcoin User" -U bitcoin \
# Intall bitcoin
  && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
  && apt-add-repository ppa:bitcoin/bitcoin \
  && apt-get update \
  && apt-get purge -y software-properties-common \
  && apt-get install -y bitcoind \
  && apt-get clean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# configure exposed ports
EXPOSE 18333 18332

# run bitcoin entrypoint
COPY .docker/bitcoin-entrypoint.sh /usr/local/bin/bitcoin-entrypoint.sh

# Changing default dir to bitcoin home
WORKDIR /bitcoin
USER bitcoin

ENTRYPOINT ["bitcoin-entrypoint.sh"]

# start bitcoind
CMD ["bitcoind"]
