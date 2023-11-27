#!/bin/bash

set -x

# dpkg -l

curl -O http://ftp.us.debian.org/debian/pool/main/a/apache2/apache2_2.4.58-1_amd64.deb \
 -O http://ftp.us.debian.org/debian/pool/main/a/apache2/apache2-bin_2.4.58-1_amd64.deb \
 -O http://ftp.us.debian.org/debian/pool/main/a/apache2/apache2-data_2.4.58-1_all.deb \
 -O http://ftp.us.debian.org/debian/pool/main/a/apache2/apache2-utils_2.4.58-1_amd64.deb
 
dpkg -i apache2-bin_2.4.58-1_amd64.deb
dpkg -i apache2-data_2.4.58-1_all.deb
dpkg -i apache2-utils_2.4.58-1_amd64.deb
dpkg -i apache2_2.4.58-1_amd64.deb

apachectl -V
apachectl -M

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

# for i in {1..60} ; do sleep 120s && ps aux && curl https://${RENDER_EXTERNAL_HOSTNAME}/ ; done &
# cp ./build_memcached.sh /tmp/
# time /tmp/build_memcached.sh &
# cp ./build_apache2.sh /tmp/
# time /tmp/build_apache2.sh 2>&1 | tee -a /var/www/html/build_log.txt &

. /etc/apache2/envvars >/dev/null 2>&1
exec /usr/sbin/apache2 -DFOREGROUND
