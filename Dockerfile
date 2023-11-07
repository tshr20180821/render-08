FROM php:8.2-apache

WORKDIR /usr/src/app

RUN apt-get update \
 && apt-get install -y \
  memcached \
  libmemcached-dev zlib1g-dev libssl-dev \
 && pecl install memcached \
 && docker-php-ext-enable memcached \
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
