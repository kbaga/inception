FROM debian:trixie

#RUN apt-get update && apt-get install -y \
#    php php-fpm php-mysql \
#    mariadb-client \
#   && rm -rf /var/lib/apt/list/*


RUN apt-get update && apt-get install -y  php8.4\
	php-fpm\
	php-mysql\
	mariadb-client\
	curl\
	bash wget \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /tmp && \
tar -xzf /tmp/wordpress-6.0-fr_FR.tar.gz -C /tmp && \
mv /tmp/wordpress/* /var/www/html/ && \
rm -rf /tmp/wordpress*

#RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's|^`listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp


COPY conf/auto_config.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

#RUN chmod +x /usr/local/bin/wp

#COPY tools/entrypoint.sh /entrypoint.sh

#RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["bash", "/entrypoint.sh"]

