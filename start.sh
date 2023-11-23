#!/bin/bash

set -x

# dpkg -l

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

# for i in {1..60} ; do sleep 30s && ps aux ; done &
# cp ./build_memcached.sh /tmp/
# time /tmp/build_memcached.sh 1>&2 &

. /etc/apache2/envvars >/dev/null 2>&1
exec /usr/sbin/apache2 -DFOREGROUND
