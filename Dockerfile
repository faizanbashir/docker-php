From faizanbashir/ubuntu-xenial:latest
MAINTAINER faizanbashir <faizan.ibn.bashir@gmail.com>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get install -y language-pack-en-base && \
  export LC_ALL=en_US.UTF-8 && \
  export LANG=en_US.UTF-8 && \
  apt-get install -y python-software-properties software-properties-common && \
  add-apt-repository ppa:ondrej/php -y && \
  apt-get update && \
  apt-get install -y \
    php7.1 \
    php7.1-fpm \
    php7.1-cli \
    php7.1-dev \
    php7.1-opcache \
    php7.1-bcmath \
    php7.1-bz2 \
    php7.1-common \
    php7.1-curl \
    php7.1-dba \
    php7.1-enchant \
    php7.1-gd \
    php7.1-imap \
    php7.1-json \
    php7.1-ldap \
    php7.1-mbstring \
    php-mcrypt \
    php7.1-pspell \
    php7.1-readline \
    php7.1-soap \
    php7.1-xml \
    php7.1-zip \
    php7.1-mysql \
    php-imagick \
    php-redis \
    php-mongodb \
    dh-make \
    mysql-client \
    composer \ 
    && \
  apt-get remove -y python-software-properties software-properties-common && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 9000

CMD [ "/bin/bash" ]