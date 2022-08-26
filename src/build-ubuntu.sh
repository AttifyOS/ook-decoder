#!/usr/bin/env sh

set -e
apt-get update
# Requires older version of go
apt-get install --yes golang-go
git clone https://github.com/jimstudt/ook-decoder
cd ook-decoder
make go-clients
tar czf go-clients.tar.gz -C ook-decoder/go/bin/ ookanalyze  ooklog  ookplay
