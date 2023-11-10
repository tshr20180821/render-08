#!/bin/bash

set -x

dpkg -l

/usr/bin/memcached --help
useradd memcached -G sasl
saslpasswd2 --help
saslpasswd2 -a memcached -c memcached
/usr/bin/memcached -vvv -B binary -d -u memcache -S

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
