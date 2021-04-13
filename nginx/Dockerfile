FROM	alpine

RUN		apk add nginx openssh openssl && \
		mkdir -p /run/nginx && \
		echo "root:toor" | chpasswd
		# echo "root:toor" | chpasswd && \
		# openssl req -x509 -nodes -days 365 \
		# -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
		# -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt && \
		# openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

# Allow ssh conexion (ssh-keygen option -A: for each of the key types for which host keys do not exist,
# generate the host keys witch the default key file path, an empty passphrase, default bits for the key type, and deafault comment).
# RUN		ssh-keygen -A

# COPY	/srcs/sshd_config			/etc/ssh/
# COPY	/srcs/telegraf.conf			/etc/telegraf/
COPY	nginx.conf			/etc/nginx/
# COPY	/srcs/ssl_params.conf		/etc/nginx/
COPY	index.html			/var/www/
COPY	start.sh				/

# We customize the SSH welcome message
# RUN		echo 'Welcome to SSH of nginx by parmarti' > /etc/motd

EXPOSE	5000
# EXPOSE	80 443 22

ENTRYPOINT	sh start.sh
