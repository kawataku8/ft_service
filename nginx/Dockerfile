FROM	alpine

RUN		apk add curl nginx openrc openssh openssl && \
		mkdir -p /run/nginx && \
		echo "root:toor" | chpasswd && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=JP/ST=Tokyo/L=Roppongi/O=42/CN=tkawahar" \
		-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt && \
		openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

RUN		ssh-keygen -A

COPY	/srcs/sshd_config			/etc/ssh/
COPY	/srcs/ssl_params.conf		/etc/nginx/
COPY	/srcs/nginx.conf			/etc/nginx/
COPY	/srcs/start.sh				/

RUN mkdir /run/openrc/
RUN touch /run/openrc/softlevel
RUN rc-update add nginx
RUN rc-update add sshd
RUN rc-status
# RUN rc-service nginx start

RUN apk add supervisor
COPY ./srcs/supervisord.conf /etc/

RUN		mkdir /www
COPY	/srcs/index.html			/www/
RUN 	adduser -D -g 'www' www
RUN		chown -R www:www /var/lib/nginx
RUN		chown -R www:www /www

# EXPOSE	80 443 22
EXPOSE 5050 443 22

CMD /usr/bin/supervisord