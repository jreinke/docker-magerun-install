FROM php:7.1-cli

MAINTAINER Johann Reinké <johann.reinke@gmail.com>

RUN apt-get update && apt-get install -y mysql-client

# Download the latest version of magerun
RUN curl http://files.magerun.net/n98-magerun-latest.phar -o /n98-magerun.phar
RUN chmod +x /n98-magerun.phar

# Add magerun-install wrapper
COPY magerun-install.sh /magerun-install.sh
RUN chmod +x /magerun-install.sh

# Declare entrypoint to magerun-install
ENTRYPOINT [ "/magerun-install.sh" ]