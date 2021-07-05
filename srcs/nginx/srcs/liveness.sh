#!/bin/sh

pgrep nginx
res_nginx=$?
pgrep telegraf
res_telegraf=$?
if [ ${res_nginx} -ne 0 -o ${res_telegraf} -ne 0 ]; then
    exit 1
else
    exit 0
fi
