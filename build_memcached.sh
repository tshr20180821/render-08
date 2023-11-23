#!/bin/bash

set -e

export CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=gold"

export CCACHE_DIR=/tmp/ccache_cache
export PATH="/tmp/usr/bin:${PATH}"

tar xf /tmp/ccache_cache.tar.bz2 -C /tmp
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

make install_sw

popd

ccache -s

# pushd /tmp
# tar cf ccache_cache.tar.bz2 --use-compress-prog=lbzip2 ./ccache_cache
# mv ccache_cache.tar.bz2 /var/www/html/
# popd
# rm -rf /tmp/ccache_cache

# find / -name openssl.pc -print

export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig

curl -LO https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz

tar xf libevent-2.1.12-stable.tar.gz

ls -lang

pushd libevent-2.1.12-stable

./configure --help

./configure --disable-shared

make

make install

popd

ccache -s

pushd /tmp
tar cf ccache_cache.tar.bz2 --use-compress-prog=lbzip2 ./ccache_cache
mv ccache_cache.tar.bz2 /var/www/html/
popd
rm -rf /tmp/ccache_cache

curl -O https://ftp.gnu.org/gnu/gsasl/gsasl-2.2.0.tar.gz

tar xf gsasl-2.2.0.tar.gz

pushd gsasl-2.2.0

./configure --help

./configure

make

make install

popd

curl -O https://memcached.org/files/memcached-1.6.22.tar.gz

tar xf memcached-1.6.22.tar.gz

pushd memcached-1.6.22

./configure --help

./configure --enable-sasl --enable-sasl-pwdb --enable-static --enable-64bit --disable-docs

make

make install

popd

ldd /usr/local/bin/memcached
cp /usr/local/bin/memcached /var/www/html/

popd
