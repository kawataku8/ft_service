FROM alpine:3.12

RUN apk update \
	&& apk add \
		openrc \
		openssl \
		nginx \
		curl \
		libc6-compat \
		wget \
		mysql \
		mysql-client \
		php php7-fpm php7-phar php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php-mbstring

#openrc
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-update add php-fpm7
RUN rc-status

#mkdirしないとdaemon offでエラー出る
RUN mkdir -p /run/nginx \
	echo "root:toor" | chpasswd && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=JP/ST=Tokyo/L=Roppongi/O=42/CN=tkawahar" \
	-keyout /etc/ssl/private/wordpress.key -out /etc/ssl/certs/wordpress.crt && \
	openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

#user追加
RUN mkdir /www
RUN adduser -D -g 'www' www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

# install wordpress
WORKDIR /www
RUN wget http://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz \
	&& chmod 755 wordpress \
	&& chown -R www:www wordpress
COPY ./srcs/wp-config.php ./wordpress/
RUN chmod 755 ./wordpress/wp-config.php \
	&& chown -R www:www ./wordpress/wp-config.php

WORKDIR /

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

# copy nginx.conf
COPY srcs/nginx.conf /etc/nginx/
RUN chmod 755 /etc/nginx/nginx.conf

# set php config file
COPY srcs/www.conf /etc/php7/php-fpm.d/
RUN chmod 755 /etc/php7/php-fpm.d/www.conf

COPY ./srcs/start.sh /
RUN	chmod 755 start.sh

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

ENTRYPOINT [ "sh", "./start.sh" ]