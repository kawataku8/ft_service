FROM alpine

RUN apk update
RUN apk add openssl
RUN apk add vsftpd
RUN apk add openrc 
RUN apk add vim

RUN mkdir /etc/vsftpd/ssl \
 && openssl genrsa -out /etc/vsftpd/ssl/server.key 2048 \
 && openssl req -new -key /etc/vsftpd/ssl/server.key -out /etc/vsftpd/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=ftps-service" \
 && openssl x509 -days 3650 -req -signkey /etc/vsftpd/ssl/server.key -in /etc/vsftpd/ssl/server.csr -out /etc/vsftpd/ssl/server.crt

RUN adduser -D test
RUN echo "test:test" | chpasswd
COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN mkdir /run/openrc/
RUN touch /run/openrc/softlevel
RUN rc-update add vsftpd
RUN rc-status
#RUN rc-service vsftpd start

#ftpクライアントのインストール
RUN apk add lftp
COPY ./srcs/.lftprc /root/.lftprc

EXPOSE 21 30021

COPY ./srcs/vsftpd_start.sh /vsftpd_start.sh


CMD ["/bin/sh", "/vsftpd_start.sh"]
