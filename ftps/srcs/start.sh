#!/bin/sh

/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
