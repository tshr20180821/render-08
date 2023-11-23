#!/bin/bash

set -x

dpkg -l

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

cp ./build_memcached.sh /tmp/
time /tmp/build_memcached.sh &

. /etc/apache2/envvars 2>&1 >/dev/null
exec /usr/sbin/apache2 -DFOREGROUND
