FROM php:7.2.13-fpm-alpine3.8

LABEL MAINTAINER="Faizan Bashir <faizan.ibn.bashir@gmail.com>"

ENV ALPINE_VERSION=3.8 \
    PHP_INI_DIR=/usr/local/etc/php \
    GROUP_ID=1000 \
    USER_ID=1000
ENV ALPINE_REPO_MAIN=http://dl.alpinelinux.org/alpine/v$ALPINE_VERSION/main/ \
    ALPINE_REPO_COMMUNITY=http://dl.alpinelinux.org/alpine/v$ALPINE_VERSION/community/

# Copy composer.lock and composer.json
#COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

RUN apk --update --repository $ALPINE_REPO_MAIN upgrade && \
    apk --update --repository $ALPINE_REPO_MAIN --repository $ALPINE_REPO_COMMUNITY \
    add --no-cache --virtual .build-runtime build-base make g++ autoconf libtool && \
    apk --update --repository $ALPINE_REPO_MAIN --repository $ALPINE_REPO_COMMUNITY \
    add --no-cache --virtual .build-dependencies git curl grep sed wget tar zip unzip postfix openssl icu icu-dev imagemagick-dev perl rabbitmq-c-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev pcre-dev libxml2-dev libgcc libstdc++ libx11 glib libxrender libxext libintl libcrypto1.0 libssl1.0 libmemcached-dev cyrus-sasl-dev && \
    apk --update --repository $ALPINE_REPO_COMMUNITY add jpegoptim && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install pdo_mysql mbstring xml json bcmath gd opcache iconv exif intl pcntl sockets zip soap calendar mysqli && \
    pecl install imagick amqp mcrypt-1.0.1 redis memcached xdebug && \
    docker-php-ext-enable imagick amqp redis memcached mcrypt opcache && \
    apk del .build-runtime && \
    rm -rf /var/cache/apk/*

# Add user for laravel application
RUN addgroup -g $GROUP_ID www
RUN adduser -D -u $USER_ID -G www www -s /bin/sh

# Copy existing application directory contents
#COPY . /var/www

# Copy existing application directory permissions
#COPY --chown=www:www . /var/www

# Change current user to www
USER www

COPY php.ini $PHP_INI_DIR/

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]