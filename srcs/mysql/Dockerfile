FROM alpine:3.12

RUN apk update \
	&& apk --no-cache add \
		openrc \
		mysql \
		wget \
		libc6-compat \
		mysql-client\
        nmap

# telegraf設定
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

#openrc設定
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-update add mariadb
RUN rc-status

# mysqldログ
RUN touch /var/log/mysqld.log \
	&& chmod 666 /var/log/mysqld.log

COPY ./srcs/start.sh /
RUN chmod 777 /start.sh

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

ENTRYPOINT [ "sh" ,"/start.sh" ]