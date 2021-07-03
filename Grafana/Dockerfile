FROM alpine:3.12

ENV GRAFANA_VERSION 7.5.4

RUN apk update \
	&& apk --no-cache add \
	openssl \
	wget \
	libc6-compat

# download grafana
RUN wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
	&& tar -zxvf grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
	&& rm grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
	&& mv /grafana-${GRAFANA_VERSION} grafana

# ssl settings
WORKDIR /etc/ssl
RUN openssl genrsa \
		-out ./private/grafana.key 2048 \
	&& openssl req -new \
		-key ./private/grafana.key \
		-out ./certs/grafana.csr \
		-subj "/C=JP/ST=Tokyo/L=Roppongi/O=42tokyo/CN=tkawahar" \
	&& openssl x509 \
		-days 3650 \
		-req -signkey ./private/grafana.key \
		-in ./certs/grafana.csr \
		-out ./certs/grafana.crt

WORKDIR /

# telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
	&& tar xf telegraf-1.17.2_linux_amd64.tar.gz \
	&& rm telegraf-1.17.2_linux_amd64.tar.gz \
	&& mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

# copy grafana general setting
COPY srcs/defaults.ini /grafana/conf/
RUN chmod 644 /grafana/conf/defaults.ini

# copy dashboard and datasources settings
COPY ./srcs/datasources/* /grafana/conf/provisioning/datasources/
COPY ./srcs/dashboards/* /grafana/conf/provisioning/dashboards/

# copy entrypoint
COPY srcs/start.sh /
RUN chmod 755 /start.sh

COPY ./srcs/liveness.sh /
RUN chmod 755 /liveness.sh

ENTRYPOINT [ "sh", "/start.sh" ]