FROM php:8.2-apache

SHELL ["/bin/bash", "-c"]

WORKDIR /usr/src/app

# iproute2 : ss
# libapr1-dev : apache
# libaprutil1-dev : apache
# libpcre2-dev : apache
# libjansson-dev : apache
# libssl-dev : apache
# libcurl4 : apache
# libbrotli-dev : apache
# zlib1g-dev : apache
# libnghttp2-dev : apache
# zstd  : dragonfly
RUN dpkg -l \
 && curl -sSLO https://github.com/dragonflydb/dragonfly/releases/download/v1.13.0/dragonfly_amd64.deb \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
  ccache \
  iproute2 \
  lbzip2 \
  libapr1-dev \
  libaprutil1-dev \
  libpcre2-dev \
  libjansson-dev \
  libssl-dev \
  libcurl4 \
  libbrotli-dev \
  zlib1g-dev \
  libnghttp2-dev \
  zstd \
 && dpkg -i dragonfly_amd64.deb \
 && MAKEFLAGS="-j $(nproc)" pecl install redis >/dev/null \
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
