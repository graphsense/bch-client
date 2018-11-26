install:
	git clone https://github.com/Bitcoin-ABC/bitcoin-abc src && \
	cd src && \
	git checkout tags/v0.18.5 -b local && \
	./autogen.sh && \
	./configure --without-gui --disable-zmq --disable-upnp-default --disable-tests --disable-wallet && \
	make install
