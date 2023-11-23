#!/bin/bash

set -e

pushd /tmp
curl -O https://memcached.org/files/memcached-1.6.22.tar.gz

tar xf memcached-1.6.22.tar.gz

cd memcached-1.6.22

./configure --help

./configure

make

popd
