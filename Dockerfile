FROM debian:stretch

# Get Dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils 
RUN apt-get -y install \
	build-essential pkg-config libcurl3-gnutls-dev libc6-dev libevent-dev m4 \
	g++-multilib autoconf libtool ncurses-dev unzip git python zlib1g-dev wget \
	bsdmainutils automake libboost-all-dev libssl-dev libprotobuf-dev \
	protobuf-compiler libqt4-dev libqrencode-dev libdb++-dev ntp ntpdate

RUN git clone https://github.com/jl777/komodo /tmp/komodo && \
	cd /tmp/komodo && \
	./zcutil/fetch-params.sh && \
	./zcutil/build.sh -j$(nproc)

EXPOSE 7771
RUN mkdir -p /komodo/data
WORKDIR /komodo

RUN cp /tmp/komodo/src/komodod .

CMD komodod --datadir=/komodo/data
