FROM alpine:3.12

RUN apk update \
	&& apk add --no-cache \
		wget \
		libc6-compat \
		influxdb

RUN mkdir -p /var/lib/influxdb

COPY ./srcs/start.sh /
RUN chmod 777 /start.sh

# telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

ENTRYPOINT [ "sh", "/start.sh"] 