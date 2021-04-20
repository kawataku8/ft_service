#!/bin/sh

rc-status
rc-service php-fpm7 start

nginx

sleep infinity