#!/bin/bash

set -x

dpkg -l

/usr/bin/memcached --help
/usr/bin/memcached -vvv -B binary -d -u memcache

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
