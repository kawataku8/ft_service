#!/bin/sh

pgrep mysqld
res_mysqld=$?
pgrep telegraf
res_telegraf=$?
if [ ${res_mysqld} -ne 0 -o ${res_telegraf} -ne 0 ]; then
    exit 1
else
    exit 0
fi
