install:
	git clone https://github.com/Bitcoin-ABC/bitcoin-abc src && \
	cd src && \
	git checkout tags/v0.21.8 -b local && \
	mkdir build && \
	cd build && \
	cmake -GNinja -DENABLE_UPNP=OFF -DBUILD_BITCOIN_WALLET=OFF -DBUILD_BITCOIN_ZMQ=OFF -DBUILD_BITCOIN_QT=OFF .. && \
	ninja && \
	ninja install
