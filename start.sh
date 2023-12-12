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

# curl -sS "${UPSTASH_REDIS_REST_URL}/set/foo/bar" \
#   -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}"

# curl -sS "${UPSTASH_REDIS_REST_URL}/get/foo" \
#   -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}"

# curl -v "${UPSTASH_REDIS_REST_URL}/get/boo" \
#   -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}"

apt-get -qq update
APT_RESULT="$(date +'%Y-%m-%d %H:%M') $(apt-get -s upgrade | grep upgraded)"

{ \
echo -n '["SET", "APT_RESULT_'; \
echo -n "${RENDER_EXTERNAL_HOSTNAME}"; \
echo -n '", "'; \
echo -n "${APT_RESULT}"; \
echo -n '"]'; \
} >/tmp/apt_result.txt

cat /tmp/apt_result.txt

curl -X POST -v -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}" \
 -d @/tmp/apt_result.txt "${UPSTASH_REDIS_REST_URL}"

{ \
echo -n '["GET", "APT_RESULT_'; \
echo -n "${RENDER_EXTERNAL_HOSTNAME}"; \
echo -n '"]'; \
} >/tmp/get_apt_result.txt

curl -X POST -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}" \
 -d @/tmp/get_apt_result.txt "${UPSTASH_REDIS_REST_URL}"

# curl -sS -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}" \
#     "${UPSTASH_REDIS_REST_URL}/set/APT_RESULT_${RENDER_EXTERNAL_HOSTNAME}/${APT_RESULT}"

#while true; \
#  do for i in {1..144}; do \
#    do for j in {1..10}; do sleep 60s && echo ${j}; done \
#     && ss -anpt \
#     && ps aux \
#     && curl -sS -A "health check" -u ${BASIC_USER}:${BASIC_PASSWORD} https://${RENDER_EXTERNAL_HOSTNAME}/; \
#  done \
#   && apt-get -qq update \
#   && APT_RESULT=$(apt-get -s upgrade | grep upgraded | base64) \
#   && curl -X POST -sS -H "Authorization: Bearer ${UPSTASH_REDIS_REST_TOKEN}" \
#       "${UPSTASH_REDIS_REST_URL}/set/APT_RESULT_${RENDER_EXTERNAL_HOSTNAME}/${APT_RESULT}"; \
#done &

sleep 5s && ss -anpt && ps aux &

. /etc/apache2/envvars >/dev/null 2>&1
exec /usr/sbin/apache2 -DFOREGROUND
