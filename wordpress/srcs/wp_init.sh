#!/bin/sh

rc-status
rc-service php-fpm7 start

cd /www/wordpress

sleep 10


wp core install \
	--url=https://wordpress-service:5050/www/wordpress \
	--title=YOUTUBE \
	--admin_user=admin \
	--admin_password=admin \
	--admin_email=wpadmin@example.com \
	--allow-root\
	--path=/www/wordpress/
wp user create bob bob@b.com \
	--role=author \
	--user_pass=bob
	--allow-root\
	--path=/www/wordpress/
wp user create john john@j.com \
	--role=author \
	--user_pass=john
	--allow-root\
	--path=/www/wordpress/
	
nginx

sleep infinity