#!/bin/sh

#launch telegraf
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

/grafana/bin/grafana-server --homepath /grafana &

sleep infinity