FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y install wget\
    php7.4\
    php7.4-fpm\
    php7.4-mysql\
    mariadb-client

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && chown www-data:www-data /run/php

RUN wget https://fr.wordpress.org/wordpress-6.6.1-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.6.1-fr_FR.tar.gz && rm wordpress-6.6.1-fr_FR.tar.gz
RUN	chown -R www-data:www-data /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/config.sh /etc/config/

RUN chmod +x /etc/config/config.sh

CMD ["/etc/config/config.sh"]