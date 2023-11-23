#!/bin/bash

set -x

dpkg -l

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

time /tmp/build_memcache.sh &

. /etc/apache2/envvars >/dev/null
exec /usr/sbin/apache2 -DFOREGROUND
