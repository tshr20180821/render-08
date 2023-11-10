#!/bin/bash

set -x

dpkg -l

getsebool -a

/usr/bin/memcached --help
useradd memcache -G sasl
saslpasswd2 -a memcache -c ${$RENDER_EXTERNAL_HOSTNAME}
/usr/bin/memcached -vvv -B binary -d -u memcache -S

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
