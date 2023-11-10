#!/bin/bash

set -x

dpkg -l

/usr/bin/memcached --help
useradd memcached -G sasl
saslpasswd2 --help
echo ${RENDER_EXTERNAL_HOSTNAME} | saslpasswd2 -p -a memcached -c memcached
/usr/bin/memcached -vvv -B binary -d -u memcached -S

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
