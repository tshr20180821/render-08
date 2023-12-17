#!/bin/bash

set -x

# dpkg -l

# docker-php-ext-install
# docker-php-ext-configure

# dragonfly --help
# dragonfly --helpfull
# export DFLY_PASSWORD=testpass999
# dragonfly --bind=127.0.0.1 --requirepass=${DFLY_PASSWORD} --version_check=false --memcached_port=11212 --tcp_keepalive=120 --port 6380 --colorlogtostderr &

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

# for i in {1..60} ; do sleep 120s && ps aux && curl https://${RENDER_EXTERNAL_HOSTNAME}/ ; done &
# cp ./build_memcached.sh /tmp/
# time /tmp/build_memcached.sh &
# cp ./build_apache2.sh /tmp/
# time /tmp/build_apache2.sh 2>&1 | tee -a /var/www/html/build_log.txt &

curl -sSLO https://github.com/tshr20180821/render-04/raw/main/Dockerfile
curl -sSLO https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
chmod +x ./hadolint-Linux-x86_64
./hadolint-Linux-x86_64 ./Dockerfile
rm ./hadolint-Linux-x86_64

sleep 5s && ss -anpt && ps aux &

a2enmod brotli
a2enmod deflate

ls -lang /etc/apache2/
ls -lang /etc/apache2/conf-available/
ls -lang /etc/apache2/mods-available/
ls -lang /etc/apache2/sites-available/
ls -lang /etc/apache2/conf-enabled/
ls -lang /etc/apache2/mods-enabled/
ls -lang /etc/apache2/sites-enabled/

cat /etc/apache2/mods-available/deflate.conf

find /etc/apache2/mods-available/ -name *.conf -exec cat '{}' ';'

curl -sS https://packages.debian.org/bookworm/apache2 | grep '<h1>' | grep 'apache2' | cut -c 13-
curl -sS https://packages.debian.org/bookworm-updates/apache2 | grep '<h1>' | grep 'apache2' | cut -c 13-
curl -sS https://packages.debian.org/bookworm-backports/apache2 | grep '<h1>' | grep 'apache2' | cut -c 13-
curl -sS https://packages.debian.org/trixie/apache2 | grep '<h1>' | grep 'apache2' | cut -c 13-
curl -sS https://packages.debian.org/sid/apache2 | grep '<h1>' | grep 'apache2' | cut -c 13-

cat /etc/apt/sources.list.d/debian.sources
ls -lang /etc/apt/

touch /var/www/html/backports_results.txt
chmod 644 /var/www/html/backports_results.txt
dpkg -l | tail -n +6 | awk '{print $2}' | awk -F: '{print $1}' | xargs -i ./backports.sh {} &

. /etc/apache2/envvars >/dev/null 2>&1
exec /usr/sbin/apache2 -DFOREGROUND
