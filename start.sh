#!/bin/bash

set -x

# dpkg -l

# find / -name memcached.conf -print
cat /etc/memcached.conf
# sasldb_path: /tmp/memcached.sasldb
echo "sasldb_path: /tmp/memcached.sasldb" >>/etc/memcached.conf
cat /etc/memcached.conf

/usr/bin/memcached --help
useradd memcached -G sasl
saslpasswd2 --help
echo ${RENDER_EXTERNAL_HOSTNAME} | saslpasswd2 -p -a memcached -c memcached -f /tmp/memcached.sasldb
chown memcached:memcached /tmp/memcached.sasldb
/usr/bin/memcached -vvv -B binary -d -u memcache -S

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
