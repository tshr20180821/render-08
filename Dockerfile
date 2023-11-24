FROM php:8.2-apache

SHELL ["/bin/bash", "-c"]

WORKDIR /usr/src/app

RUN dpkg -l \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
  ccache \
  lbzip2 \
  libevent-dev \
  libsasl2-dev \
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
