#!/bin/sh

pgrep influxd
res_influxd=$?
pgrep telegraf
res_telegraf=$?
if [ ${res_influxd} -ne 0 -o ${res_telegraf} -ne 0 ]; then
    exit 1
else
    exit 0
fi
