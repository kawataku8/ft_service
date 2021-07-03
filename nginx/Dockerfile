FROM alpine:3.12

RUN		apk add curl nginx openrc openssl libc6-compat && \
		mkdir -p /run/nginx && \
		echo "root:toor" | chpasswd && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=JP/ST=Tokyo/L=Roppongi/O=42/CN=tkawahar" \
		-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt && \
		openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

COPY	/srcs/nginx.conf			/etc/nginx/
COPY	/srcs/start.sh				/
RUN		chmod 777 /start.sh

RUN mkdir /run/openrc/
RUN touch /run/openrc/softlevel
RUN rc-update add nginx
RUN rc-status

RUN		mkdir /www
COPY	/srcs/index.html			/www/
RUN 	adduser -D -g 'www' www
RUN		chown -R www:www /var/lib/nginx
RUN		chown -R www:www /www


RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

ENTRYPOINT [ "sh", "/start.sh" ]
