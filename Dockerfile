# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: takuya <takuya@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/12 22:55:22 by tkawahar          #+#    #+#              #
#    Updated: 2021/03/27 21:11:10 by takuya           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# OS image
FROM debian:buster
#Maintainer
LABEL maintainer="tkawahar <tkawahar@student.42tokyo.jp>"
#コマンド、ツールのインストール
RUN	set -ex; \
	apt-get update && apt-get -y install \
		vim \
		wget \
		ca-certificates openssl \
		mariadb-server mariadb-client \
		php7.3 php7.3-fpm php7.3-mysql php-mbstring \
		supervisor; \
	rm -rf /var/lib/apt/lists/*
# mysqlの設定
RUN set -ex; \
		service mysql start; \
		mysql -e "CREATE DATABASE testdb;"; \
		mysql -e "CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'dbpass';"; \
		mysql -e "GRANT ALL PRIVILEGES ON testdb.* TO 'testuser'@'localhost';"
# wgetでwordpress、phpmyadminのインストール　解凍してvar/www/htmlに移動
RUN	set -ex; \
		wget --no-check-certificate https://wordpress.org/latest.tar.gz; \
		tar -xvzf latest.tar.gz; \
		rm latest.tar.gz; \
		mv wordpress var/www/html; \
		wget --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz; \
		tar -xvzf phpMyAdmin-5.0.4-all-languages.tar.gz; \
		rm phpMyAdmin-5.0.4-all-languages.tar.gz; \
		mv phpMyAdmin-5.0.4-all-languages phpmyadmin; \
		mv phpmyadmin var/www/html; \
# 事前に用意した設定ファイルを設置、置き換える
COPY	./srcs/config.inc.php /var/www/html/phpmyadmin/config.sample.inc.php
COPY	./srcs/wp-config.php /var/www/html/wordpress/wp-config.php
COPY	./srcs/default /etc/nginx/sites-available/default
COPY	./srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# www-dataにディレクトリの実行権限を付与 supervisordファイルの権限変更
RUN		chown -R www-data:www-data /var/www/html/*
RUN		chmod +x /etc/supervisor/conf.d/supervisord.conf
# ポート開放
EXPOSE	5050
# autoindex変数
ENV AUTOINDEX=on
#引数に応じてAUTOINDEX変更＆プログラム起動
ENTRYPOINT	supervisord
