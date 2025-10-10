#!/bin/sh
set -eu
HUGO_VERSION=0.150.0
ARCH=$(dpkg --print-architecture)
wget -q -O /tmp/hugo.deb \
	"https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.deb"
dpkg -i /tmp/hugo.deb
rm -f /tmp/hugo.deb
exit 0
