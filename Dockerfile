FROM debian:stretch-slim

# Get Dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils 
RUN apt-get -y install \
	build-essential pkg-config libcurl3-gnutls-dev libc6-dev libevent-dev m4 g++-multilib autoconf \
	libtool ncurses-dev unzip git python zlib1g-dev wget bsdmainutils automake libboost-all-dev libssl-dev \
	libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev libdb++-dev ntp ntpdate

# Build
RUN git clone https://github.com/KomodoPlatform/komodo.git /tmp/coin-daemon
WORKDIR /tmp/coin-daemon
RUN ./zcutil/fetch-params.sh
RUN ./zcutil/build.sh -j$(nproc)

RUN mkdir -p /coin/data

WORKDIR /coin
RUN cp /tmp/coin-daemon/src/komodod ./daemon
RUN cp /tmp/coin-daemon/src/komodo-cli ./cli

EXPOSE 3000
EXPOSE 3001
CMD ./daemon --datadir=/coin/data
