#!/bin/bash

set -x

# dpkg -l

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

# for i in {1..60} ; do sleep 120s && curl https://${RENDER_EXTERNAL_HOSTNAME}/ ; done &
# cp ./build_memcached.sh /tmp/
# time /tmp/build_memcached.sh &

. /etc/apache2/envvars >/dev/null 2>&1
exec /usr/sbin/apache2 -DFOREGROUND
