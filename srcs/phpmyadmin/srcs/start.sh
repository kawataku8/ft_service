#!/bin/sh

rc-status
rc-service php-fpm7 start
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
nginx
sleep infinity