FROM php:7.2.4-fpm-alpine3.7
LABEL MAINTAINER="Faizan Bashir <faizan.ibn.bashir@gmail.com>"

ENV PHP_INI_DIR /usr/local/etc/php

RUN apk --update \
        --repository http://dl-3.alpinelinux.org/alpine/v3.6/main/ \
        upgrade && \
    apk --update \
        --repository http://dl-3.alpinelinux.org/alpine/v3.6/main/ \
        --repository http://dl-3.alpinelinux.org/alpine/v3.6/community/ \
        add bash shadow git curl vim grep sed wget tar gzip postfix openssl icu icu-dev libtool imagemagick-dev make g++ autoconf perl rabbitmq-c-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev pcre-dev libxml2-dev ttf-freefont libgcc libstdc++ libx11 glib libxrender libxext libintl libcrypto1.0 libssl1.0 libmemcached-dev cyrus-sasl-dev && \
        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	    chmod +x /usr/local/bin/composer && \
    apk --update \
        --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
        add jpegoptim && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install iconv gd bcmath exif intl opcache pcntl json xml sockets zip pdo_mysql soap calendar mysqli && \
    pecl install imagick amqp mcrypt-1.0.1 redis memcached xdebug && \
    docker-php-ext-enable imagick amqp redis memcached mcrypt opcache && \
    apk del --purge make g++ autoconf libtool && \
    rm -rf /var/cache/apk/*

COPY run.sh /run.sh

COPY wkhtmltopdf /usr/local/bin

COPY php.ini $PHP_INI_DIR/

EXPOSE 9000

CMD /run.sh