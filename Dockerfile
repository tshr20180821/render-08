FROM php:8.2-apache

SHELL ["/bin/bash", "-c"]

WORKDIR /usr/src/app

# libevent-dev : memcached
# libsasl2-dev : memcached
# libapr1-dev : apache
# libaprutil1-dev : apache
# libpcre2-dev : apache
# libjansson-dev : apache
# libssl-dev : apache
# libcurl4 : apache
# libbrotli-dev : apache
# zlib1g-dev : apache

RUN dpkg -l \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
  ccache \
  lbzip2 \
  libevent-dev \
  libsasl2-dev \
  libapr1-dev \
  libaprutil1-dev \
  libpcre2-dev \
  libjansson-dev \
  libssl-dev \
  libcurl4 \
  libbrotli-dev \
  zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && a2dissite -q 000-default.conf \
 && a2enmod -q authz_groupfile rewrite \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && touch /var/www/html/index.html

COPY ./php.ini ${PHP_INI_DIR}/
COPY ./apache.conf /etc/apache2/sites-enabled/
COPY ./*.php /var/www/html/

COPY ./start.sh /usr/src/app/

COPY --chmod=755 ./*.sh ./
# COPY ./ccache_cache.tar.bz2 /tmp/

# RUN /tmp/build_memcached.sh

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
