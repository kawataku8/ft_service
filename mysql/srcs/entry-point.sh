#!/bin/sh

# create database
/etc/init.d/mariadb setup
rc-status
rc-service mariadb start
mysql -e "CREATE DATABASE wpdb;"
mysql -e "CREATE USER 'admin'@'%' identified by 'admin';"
mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'admin'@'%';"
mysql -e "FLUSH PRIVILEGES;"
rc-service mariadb stop

#start mysqld
/usr/bin/mysqld \
	--user=mysql \
	--datadir=/var/lib/mysql \
	--plugin-dir=/usr/lib/mariadb/plugin \
	--pid-file=/run/mysqld/mariadb.pid \
	--port=3306 \
	--log-error=/var/log/mysqld.log \
	--log-warnings=4 \
	--skip-networking=0

sleep infinity