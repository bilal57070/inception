sleep 8

wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--path='/var/www/wordpress'

wp core install --allow-root \
	--url="https://$DOMAIN" \
	--title=$TITLE \
	--admin_user=$ADMIN_NAME \
	--admin_password=$ADMIN_PASSWORD \
	--admin_email=$ADMIN_EMAIL \
	--path='/var/www/wordpress'

wp user create --allow-root \



/usr/sbin/php-fpm7.3 -F