#!/bin/bash

set -e

export CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=gold"

export CCACHE_DIR=/tmp/ccache_cache
export PATH="/tmp/usr/bin:${PATH}"

mkdir -p /tmp/ccache_cache
tar xf /tmp/ccache_cache.tar.bz2 -C /tmp/ccache_cache
ls -lang /tmp/ccache_cache

mkdir -p /tmp/usr/bin

pushd /tmp/usr/bin
ln -s /usr/bin/ccache gcc
ln -s /usr/bin/ccache g++
ln -s /usr/bin/ccache cc
ln -s /usr/bin/ccache c++
popd

ccache --version
ccache -s
ccache -z
ccache -M 500M

pushd /tmp

curl -LO https://www.openssl.org/source/openssl-3.1.4.tar.gz

tar xf openssl-3.1.4.tar.gz

ls -lang

pushd openssl-3.1.4

ls -lang

./Configure --help

./Configure

make

popd

ccache -s

pushd /tmp
tar cf ccache_cache.tar.bz2 --use-compress-prog=lbzip2 ./ccache_cache
mv ccache_cache.tar.bz2 /var/www/html/
popd
rm -rf /tmp/ccache_cache

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
