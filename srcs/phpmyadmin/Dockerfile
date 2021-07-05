FROM alpine:3.12

# https://wiki.alpinelinux.org/wiki/PhpMyAdmin
RUN apk update \
	&& apk add \
		openrc \
		openssl \
		nginx \
		wget \
		mysql \
		libc6-compat \
		mysql-client \
		php-mbstring \
		php php7-fpm php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN mkdir -p /run/nginx \
	echo "root:toor" | chpasswd && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=JP/ST=Tokyo/L=Roppongi/O=42/CN=tkawahar" \
	-keyout /etc/ssl/private/phpmyadmin.key -out /etc/ssl/certs/phpmyadmin.crt && \
	openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

#openrc
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-update add php-fpm7
RUN rc-status

#user追加
RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

WORKDIR /www/
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
	&& chown -R www:www phpmyadmin \
	&& chmod -R 777 /www

WORKDIR /

# telegraf設定
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

# copy nginx.conf
COPY srcs/nginx.conf /etc/nginx/
RUN chmod 755 /etc/nginx/nginx.conf

# copy phpmyadmin conf
COPY srcs/config.inc.php /www/phpmyadmin
RUN chmod 644 /www/phpmyadmin/config.inc.php

# copy entrypoint
COPY ./srcs/start.sh /
RUN	chmod 755 /start.sh

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

ENTRYPOINT [ "sh", "/start.sh" ]