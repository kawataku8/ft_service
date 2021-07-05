FROM alpine:3.12

RUN apk update \
    && apk --no-cache add \
    openssl\
    vsftpd \
    openrc \
    vim \
    wget \
    libc6-compat


RUN mkdir /etc/vsftpd/ssl \
 && openssl genrsa -out /etc/vsftpd/ssl/server.key 2048 \
 && openssl req -new -key /etc/vsftpd/ssl/server.key -out /etc/vsftpd/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=ftps-service" \
 && openssl x509 -days 3650 -req -signkey /etc/vsftpd/ssl/server.key -in /etc/vsftpd/ssl/server.csr -out /etc/vsftpd/ssl/server.crt

# telegraf設定
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

RUN adduser -D bob
RUN echo "bob:bob" | chpasswd
COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN mkdir /run/openrc/
RUN touch /run/openrc/softlevel
RUN rc-update add vsftpd
RUN rc-status


# EXPOSE 21 30021

COPY ./srcs/start.sh /
RUN chmod 755 /start.sh

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

CMD ["sh", "/start.sh"]
