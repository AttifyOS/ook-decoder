#!/bin/sh

set -e
apk update
apk add alpine-sdk libusb-dev librtlsdr-dev
ln -s /usr/lib/libusb-1.0.a /usr/lib/libusb.a

git clone https://github.com/jimstudt/ook-decoder
cd ook-decoder

sed -i -e '/^DEBUGFLAGS/ d; /^LDLIBS +=/ c LDLIBS += -lm -lusb' -e 's/^CFLAGS = $(COMPILERFLAGS)/CFLAGS = $(COMPILERFLAGS) -static/; s/^all : daemon clients go-clients man-pages/all : daemon clients/' Makefile
make
find . -maxdepth 1 -type f -executable -exec tar czf ../ookbins.tar.gz '{}' \+
