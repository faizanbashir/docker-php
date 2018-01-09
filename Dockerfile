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
    php7.2 \
    php7.2-fpm \
    php7.2-cli \
    php7.2-dev \
    php7.2-opcache \
    php7.2-bcmath \
    php7.2-bz2 \
    php7.2-common \
    php7.2-curl \
    php7.2-dba \
    php7.2-enchant \
    php7.2-gd \
    php7.2-imap \
    php7.2-json \
    php7.2-ldap \
    php7.2-mbstring \
    php-mcrypt \
    php7.2-pspell \
    php7.2-readline \
    php7.2-soap \
    php7.2-xml \
    php7.2-zip \
    php7.2-mysql \
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

# Data Volumes
# RUN mkdir -p /app
# VOLUME [ "/app" ]

#Expose port 9000
EXPOSE 9000

ENTRYPOINT ["/etc/init.d/php7.2-fpm", "start"]