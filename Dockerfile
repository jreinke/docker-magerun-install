FROM php:7.1-cli

MAINTAINER Johann Reinké <johann.reinke@gmail.com>

RUN apt-get update && apt-get install -y mysql-client

ENV PHP_EXT_APCU_VERSION "5.1.7"
RUN build_packages="libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev libxslt1-dev libmemcached-dev sendmail-bin sendmail libicu-dev" \
    && apt-get update && apt-get install -y $build_packages \
    && yes "" | pecl install apcu-$PHP_EXT_APCU_VERSION && docker-php-ext-enable apcu \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && docker-php-ext-install zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download the latest version of magerun
RUN curl http://files.magerun.net/n98-magerun-latest.phar -o /n98-magerun.phar
RUN chmod +x /n98-magerun.phar

# Add magerun-install wrapper
COPY magerun-install.sh /magerun-install.sh
RUN chmod +x /magerun-install.sh

# Declare entrypoint to magerun-install
ENTRYPOINT [ "/magerun-install.sh" ]