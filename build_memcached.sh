#!/bin/bash

set -e

pushd /tmp

curl -LO https://www.openssl.org/source/openssl-3.1.4.tar.gz

tar xf openssl-3.1.4.tar.gz

ls -lang

pushd openssl-3.1.4

ls -lang

./configure --help

./configure

make

popd

exit

curl -LO https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz

tar xf libevent-2.1.12-stable.tar.gz

ls -lang

pushd libevent-2.1.12-stable

./configure --help

./configure

make

popd

curl -O https://memcached.org/files/memcached-1.6.22.tar.gz

tar xf memcached-1.6.22.tar.gz

pushd memcached-1.6.22

./configure --help

./configure

make

popd

popd