FROM alpine:3.13

RUN apk update \
	&& apk --no-cache add \
		openrc \
		mysql \
		mysql-client\
        nmap

#openrc
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-update add mariadb
RUN rc-status

# mysqldのログ設定
RUN touch /var/log/mysqld.log \
	&& chmod 666 /var/log/mysqld.log

COPY ./srcs/entry-point.sh /
RUN chmod 755 /entry-point.sh

ENTRYPOINT [ "/entry-point.sh" ]