#!/bin/sh

rc-status
rc-service php-fpm7 start

/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

cd /www/wordpress

wp core install \
	--url=https://192.168.49.50:5050 \
	--title=FTSERVICES_BLOG \
	--admin_user=admin \
	--admin_password=admin \
	--admin_email=wpadmin@example.com

# if mysql doesn't started yet, last command would fail
cmd_res=$?
if [ $cmd_res -ne 0 ]; then
	echo "mysql doesnt started yet"
	return 1;
fi

wp user create bob bob@b.com \
	--role=author \
	--user_pass=bob
wp user create john john@j.com \
	--role=author \
	--user_pass=john
	
nginx

sleep infinity