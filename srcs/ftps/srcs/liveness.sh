#!/bin/sh

pgrep vsftpd
res_vsftpd=$?
pgrep telegraf
res_telegraf=$?
if [ ${res_vsftpd} -ne 0 -o ${res_telegraf} -ne 0 ]; then
    exit 1
else
    exit 0
fi
