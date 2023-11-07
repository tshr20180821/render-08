FROM php:8.2-apache

WORKDIR /usr/src/app

RUN apt-get update \
 && apt-get install -y \
  memcached \
 && apt-cache search memcached \
 && curl -o /tmp/php8.2-memcached_3.2.0+2.2.0-4_amd64.deb http://ftp.jp.debian.org/debian/pool/main/p/php-memcached/php8.2-memcached_3.2.0+2.2.0-4_amd64.deb \
 && dpkg -i --force-depends /tmp/php8.2-memcached_3.2.0+2.2.0-4_amd64.deb \
 && dpkg --audit \
 && apt-get -f install \
 && dpkg --audit \
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
 
ENTRYPOINT ["bash","/usr/src/app/start.sh"]

# 
