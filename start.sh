#!/bin/bash

set -x

# dpkg -l

cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -c 14-

/usr/bin/memcached --help
useradd memcached -G sasl
saslpasswd2 --help
# echo ${RENDER_EXTERNAL_HOSTNAME} | saslpasswd2 -p -f /tmp/memcached.sasldb -a memcached -c memcached
echo ${RENDER_EXTERNAL_HOSTNAME} | saslpasswd2 -p -a memcached -c memcached
# chown memcached:memcached /tmp/memcached.sasldb
chown memcached:memcached /etc/sasldb2
# cat /tmp/memcached.sasldb
sasldblistusers2
# export MEMCACHED_SASL_PWDB=/tmp/memcached.sasldb

export SASL_CONF_PATH=/tmp/memcached.conf
echo "mech_list: plain cram-md5" >/tmp/memcached.conf
# echo "mech_list: login plain anonymous ntlm scram cram-md5 digest-md5" >/tmp/memcached.conf
# echo "sasldb_path: /tmp/memcached.sasldb" >>/tmp/memcached.conf
cat /tmp/memcached.conf
/usr/sbin/saslauthd --help
/usr/sbin/saslauthd -a sasldb -V

testsaslauthd -u memcached -p ${RENDER_EXTERNAL_HOSTNAME}

/usr/bin/memcached -S -v -B binary -d -u memcached

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
