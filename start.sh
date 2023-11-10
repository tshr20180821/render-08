#!/bin/bash

set -x

# dpkg -l

/usr/bin/memcached --help
useradd memcached -G sasl
saslpasswd2 --help
echo ${RENDER_EXTERNAL_HOSTNAME} | saslpasswd2 -p -f /tmp/memcached.sasldb -a memcached -c memcached
chown memcached:memcached /tmp/memcached.sasldb
# cat /tmp/memcached.sasldb
export MEMCACHED_SASL_PWDB=/tmp/memcached.sasldb

echo "mech_list: cram-md5 digest-md5 login plain" >/tmp/memcached.conf
echo "sasldb_path: /tmp/memcached.sasldb" >>/tmp/memcached.conf
cat /tmp/memcached.conf

export SASL_CONF_PATH=/tmp/memcached.conf

/usr/bin/memcached -S -v -B binary -d -u memcached

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
