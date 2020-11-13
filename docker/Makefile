install:
	git clone --depth=1 -b v0.22.6 https://github.com/Bitcoin-ABC/bitcoin-abc src && \
	mkdir -p src/build && \
	cd src/build && \
	cmake -GNinja -DENABLE_UPNP=OFF -DBUILD_BITCOIN_WALLET=OFF -DBUILD_BITCOIN_ZMQ=OFF -DBUILD_BITCOIN_QT=OFF .. && \
	ninja && \
	ninja install
