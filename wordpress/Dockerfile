FROM alpine:3.13

ENV WP_VERSION 5.7

RUN apk update \
	&& apk add \
		openrc \
		openssl \
		nginx \
		curl \
		mysql \
		mysql-client \
		php php7-fpm php7-phar php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php-mbstring

#openrc
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-update add php-fpm7
RUN rc-status


#mkdirしないとdaemon offでエラー出る
RUN mkdir -p /run/nginx

# nginxで使うhttpsのための設定
WORKDIR /etc/ssl
RUN openssl genrsa \
		-out ./private/wordpress.key 2048 \
	&& openssl req -new \
		-key ./private/wordpress.key \
		-out ./certs/wordpress.csr \
		-subj "/C=JP/ST=Tokyo/L=Roppongi/O=42tokyo/CN=tkawahar" \
	&& openssl x509 \
		-days 3650 \
		-req -signkey ./private/wordpress.key \
		-in ./certs/wordpress.csr \
		-out ./certs/wordpress.crt

#user追加
RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

# install wordpress
WORKDIR /www
RUN wget http://wordpress.org/wordpress-"${WP_VERSION}".tar.gz \
	&& tar -xzvf wordpress-"${WP_VERSION}".tar.gz \
	&& rm wordpress-"${WP_VERSION}".tar.gz \
	&& chmod 755 wordpress \
	&& chown -R www:www wordpress
COPY ./srcs/wp-config.php ./wordpress/
RUN chmod 644 ./wordpress/wp-config.php \
	&& chown -R www:www ./wordpress/wp-config.php

WORKDIR /

# RUN ln -s /www/wordpress/ /var/www/localhost/htdocs/wordpress

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# copy nginx.conf
COPY srcs/nginx.conf /etc/nginx/
RUN chmod 755 /etc/nginx/nginx.conf

# set php config file
COPY srcs/www.conf /etc/php7/php-fpm.d/
RUN chmod 755 /etc/php7/php-fpm.d/www.conf

COPY ./srcs/wp_init.sh /
RUN	chmod 755 wp_init.sh

ENTRYPOINT [ "./wp_init.sh" ]