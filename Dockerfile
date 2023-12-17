FROM php:8.3-apache

EXPOSE 80

SHELL ["/bin/bash", "-c"]

WORKDIR /usr/src/app

ENV CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
ENV CXXFLAGS="${CFLAGS}"
ENV LDFLAGS="-fuse-ld=gold"

# iproute2 : ss
# zstd  : dragonfly
RUN set -x \
 && dpkg -l \
 && curl -sSLO https://github.com/dragonflydb/dragonfly/releases/download/v1.13.0/dragonfly_amd64.deb \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
  ccache \
  iproute2 \
  zstd \
 && dpkg -i dragonfly_amd64.deb \
 && time MAKEFLAGS="-j $(nproc)" pecl install redis >/dev/null \
 && docker-php-ext-enable redis \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && a2dissite -q 000-default.conf \
 && a2enmod -q authz_groupfile rewrite \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && touch /var/www/html/index.html

COPY ./php.ini ${PHP_INI_DIR}/
COPY ./apache.conf /etc/apache2/sites-enabled/
COPY ./*.php /var/www/html/

COPY --chmod=755 ./*.sh ./
# COPY ./ccache_cache.tar.bz2 /tmp/

# RUN /tmp/build_memcached.sh

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
