#!/bin/bash

set -x

# dpkg -l

/usr/bin/memcached --help
useradd memcached -G sasl
saslpasswd2 --help
echo ${RENDER_EXTERNAL_HOSTNAME} | saslpasswd2 -p -a memcached -c memcached -f /tmp/memcached.sasldb
chown memcached:memcached /tmp/memcached.sasldb
# cat /tmp/memcached.sasldb
export MEMCACHED_SASL_PWDB=/tmp/memcached.sasldb

echo "mech_list: plain cram-md5" >/tmp/memcached.conf
echo "sasldb_path: /tmp/test-memcached.sasldb" >>/tmp/memcached.conf
cat /tmp/memcached.conf

export SASL_CONF_PATH=/tmp/memcached.conf

/usr/bin/memcached -S -v -B binary -d -u memcached

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
