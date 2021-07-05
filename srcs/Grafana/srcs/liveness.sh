#!/bin/sh

pgrep grafana
res_grafana=$?
pgrep telegraf
res_telegraf=$?
if [ ${res_grafana} -ne 0 -o ${res_telegraf} -ne 0 ]; then
    exit 1
else
    exit 0
fi
