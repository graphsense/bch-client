install:
	git clone --depth=1 -b v27.0.0 https://gitlab.com/bitcoin-cash-node/bitcoin-cash-node src && \
	mkdir -p src/build && \
	cd src/build && \
	cmake -GNinja -DENABLE_UPNP=OFF -DBUILD_BITCOIN_WALLET=OFF -DBUILD_BITCOIN_ZMQ=OFF -DBUILD_BITCOIN_QT=OFF .. && \
	ninja && \
	ninja install
