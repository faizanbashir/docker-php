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
    php5.6 \
    php5.6-fpm \
    php5.6-cli \
    php5.6-dev \
    php5.6-opcache \
    php5.6-bcmath \
    php5.6-bz2 \
    php5.6-common \
    php5.6-curl \
    php5.6-dba \
    php5.6-enchant \
    php5.6-gd \
    php5.6-imap \
    php5.6-json \
    php5.6-ldap \
    php5.6-mbstring \
    php-mcrypt \
    php5.6-pspell \
    php5.6-readline \
    php5.6-soap \
    php5.6-xml \
    php5.6-zip \
    php5.6-mysql \
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