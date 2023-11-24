#!/bin/bash

set -e

export CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=gold"

APACHE_VERSION=2.4.58

pushd /tmp

curl -O https://ftp.jaist.ac.jp/pub/apache//httpd/httpd-${APACHE_VERSION}.tar.bz2

tar xf httpd-${APACHE_VERSION}.tar.bz2
target=httpd-${APACHE_VERSION}
pushd ${target}
./configure --help
# ./configure --prefix=/tmp/usr \
#   --enable-mods-shared="few" \
#   --enable-brotli --enable-file-cache \
#   --disable-authn-core --disable-authn-file --disable-access-compat --disable-authn-core \
#   --disable-authz-core --disable-authz-host --disable-authz-user --disable-authz-groupfile --disable-auth-basic \
#   --disable-autoindex --disable-alias --disable-dir --disable-env --disable-filter --disable-headers \
#   --disable-log_config --disable-mime --disable-reqtimeout --disable-setenvif --disable-status --disable-unixd --disable-version
./configure
time make
make install

popd
