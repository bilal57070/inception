#!/bin/bash

sleep 8

if [ ! -f "wp-config.php" ]; then
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path='/var/www/wordpress'
fi

if ! wp core is-installed 2>/dev/null; then
	wp core install --allow-root \
		--url="https://$DOMAIN" \
		--title=$TITLE \
		--admin_user=$ADMIN_NAME \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--path='/var/www/wordpress'
fi

if ! wp user exists 2 --allow-root 2>/dev/null; then
	wp user create --user_login=$USER_NAME \
		--user_password=$USER_PASSWORD \
		--user_email=$USER_EMAIL \
		--path='/var/www/wordpress'
fi


/usr/sbin/php-fpm7.4 -F